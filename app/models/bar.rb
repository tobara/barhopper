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

    bars.each {
                |bar|
                bar_id = bar.id
                unless Bar.have_today?(bar_id)
                query = bar.popular_query
                Bar.get_pop_page(bar_id, query)
                end
                bar.bar_img = "bar#{n}"
                n += 1
              }
  end

  def self.have_today?(bar_id)
    @today = Time.now.strftime("%A")
    Day.where(bar_id: bar_id).pluck(:day).include?(@today)
  end

  def self.get_pop_page(bar_id, query)
    pop_times = []
    agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
    agent.get(query).body
    hours_open = agent.page.search("span[@class='_Map']").text.split('–')
    open_hours = DateTime.parse(hours_open[0]).strftime("%H").to_i
    popularity = agent.page.search("div[@class='lubh-bar']")
    popularity.map { |pop| pop_times << pop.attributes["style"].value.scan(/\d+/)[0] }
    Bar.assign_pop_times(open_hours, pop_times, bar_id)
  end

  def self.assign_pop_times(open_hours, pop_times, bar_id)

    closed_hours = 0
    today = Time.now.strftime("%A")
    while closed_hours < 24
      day = Day.new
      day.attributes = { :day => today, :hour => closed_hours, :popularity => 0, :bar_id => bar_id }
      day.save
      closed_hours += 1
    end
    pop_times.each { |pop|
                    Bar.assign_hour(open_hours, today, pop, bar_id)
                    binding.pry
                    open_hours += 1
                   }
  end

  def self.assign_hour(open_hours, today, pop, bar_id)
    open_hours -= 12 if open_hours > 23
    day = Day.where(bar_id: bar_id, day: today, hour: open_hours)
    day.first.attributes = { :popularity => pop }
    day.first.save
  end
end
