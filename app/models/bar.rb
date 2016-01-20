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
end
