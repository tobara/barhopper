class Bar < ActiveRecord::Base
  acts_as_votable
  belongs_to :user
  has_many :comments

  validates :user, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
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
    bars.each do |bar|
      @bar_name = bar.name
      @bar_name += " #{bar.location}"
      @bar_name.gsub(" ","+")
      url = "http://www.google.com/search?q="+"#{@bar_name}"+"&num=10"
      agent = Mechanize.new { |agent| agent.user_agent_alias = "Mac Safari" }
      html = agent.get(url).body
      doc = Nokogiri::HTML(html)
      doc_string = doc.to_s
      doc_find = nil
      if result = doc_string.match(/lubh-bar( _...)/)
        doc_find = result.captures
        div_end = doc_find[0]
        div_find = "lubh-bar"+"#{div_end}"
        doc_at = doc.xpath("//div[@class=\"#{div_find}\"]")
      end
      if doc_at.nil?
        bar_pop = 0
      else
        doc_style = doc_at[0]["style"]
        bar_pop = doc_style.gsub(/[^0-9]/, '')
      end
      bar.attributes = { :popular_time => bar_pop }
      pop_value = bar.popular_time.to_i
      n += 1
      bar.attributes = { :bar_img => "bar#{n}" }
    end
  end
end
