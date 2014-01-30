class User < ActiveRecord::Base
  include RatingAverage
  has_many :ratings
  has_many :raters, through: :ratings, source: :user
  has_many :beer_clubs, through: :memberships
  validates :username, uniqueness: true, length: { minimum: 3, maximum: 15 }
end
