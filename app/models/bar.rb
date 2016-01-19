class Bar < ActiveRecord::Base
  belongs_to :user
  has_many :comments

  validates :user, presence: true
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :location, presence: true
  validates :address, presence: true
end
