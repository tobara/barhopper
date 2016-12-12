class Bar < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :comments
  has_many :days

  validates :user, presence: true
  validates :name, presence: true, uniqueness: true
  validates :location, presence: true
  validates :address, presence: true

  def initialize
    @today = Time.now.strftime("%A")
  end

  def upvotes_score
    self.get_upvotes.size
  end

  def downvotes_score
    (self.get_downvotes.size) * -1
  end

  def self.popular_times(bars)
    n = 0
    bars.each {
                |bar|
                query = bar.popular_query
                bar_id = bar.id
                Bar.get_pop_page(bar_id, query) if not Bar.have_today?(bar_id)
                bar.bar_img = "bar#{n}"
                n += 1
              }
  end

  def self.have_today?(bar_id)
    Day.where(bar_id: bar_id).pluck(:day).include?(@today)
  end

  def self.get_pop_page(bar_id, query)
    pop_times = []
    agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
    agent.get(query).body
    hours_open = agent.page.search("span[@class='_Map']").text.split('–')
    open_hour = DateTime.parse(hours_open[0]).strftime("%H").to_i
    popularity = agent.page.search("div[@class='lubh-bar']")
    popularity.map { |pop| pop_times << pop.attributes["style"].value.scan(/\d+/)[0] }
    Bar.assign_pop_times(open_hour, pop_times, bar_id)
  end

  def self.assign_pop_times(open_hour, pop_times, bar_id)
    day = Day.new
    pop_times.each { |pop|
                    Bar.assign_hour(open_hour, day, pop, bar_id)
                    open_hour += 1
                   }
  end

  def self.assign_hour(open_hour, day, pop, bar_id)
    day.attributes = { :day => @today, :hour => open_hour, :popularity => pop, :bar_id => bar_id }
    day.save
  end
end
