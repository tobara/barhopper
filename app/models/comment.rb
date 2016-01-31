class Comment < ActiveRecord::Base
  belongs_to :bar
  belongs_to :user, dependent: :destroy

  validates :user_id, uniqueness: { scope: :bar_id }
  validates :bar, presence: true
  validates :description, presence: true
  validates :rating, presence: true
  validates :rating, numericality: {
    greater_than: 0,
    less_than_or_equal_to: 10 }
end
