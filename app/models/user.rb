class User < ActiveRecord::Base
  has_many :bars
  has_many :comments

  devise(
    :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable)

  validates :username, presence: true
end
