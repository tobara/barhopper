class Bar < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :comments
  has_many :days

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :address, presence: true

  def upvotes_score
    self.get_upvotes.size
  end

  def downvotes_score
    (self.get_downvotes.size) * -1
  end

  def self.popular_times(bars)
    n = 0
    day_now = Time.now.strftime("%A")
    bars.each do |bar|
      agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
      agent.get(bar.popular_query).body
      hours_open = agent.page.search("span[@class='_Map']").text.split('–')
      open_hour = DateTime.parse(hours_open[0]).strftime("%H").to_i
      popularity = agent.page.search("div[@class='lubh-bar']")
      popularity.each do |pop|
        pop = pop.attributes["style"].value.scan(/\d+/)[0]
        day = Day.new
        day.attributes = { :day => day_now, :hour => open_hour, :popularity => pop, :bar_id => bar.id }
        day.save
        open_hour += 1
      end
      n += 1
      bar.attributes = { :bar_img => "bar#{n}" }
    end
  end
end
