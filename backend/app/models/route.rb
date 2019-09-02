class Route < ApplicationRecord
  enum route_type: [ :walk, :bike, :car ]
  belongs_to :user
  has_many :points_routes
  has_many :points, through: :points_routes
  has_many :events
  has_many :comments, as: :commentable
  has_many_attached :route_images
end
