class Route < ApplicationRecord
  enum route_type: [ :walk, :bike, :car ]

  has_many :points_routes
  has_many :points, through: :points_routes

  has_many :events

  belongs_to :user

  has_many :comments, as: :commentable
end
