# frozen_string_literal: true

class Route < ApplicationRecord
  belongs_to :user
  has_many :events
  has_many :points_routes, dependent: :destroy
  has_many :points, through: :points_routes
  has_many :comments, as: :commentable, dependent: :destroy

  has_many_attached :route_images

  validates :name, presence: true
  validates :name, uniqueness: { scope: :movement_type, message: 'A route with the same name already exists.' }

  ratyrate_rateable 'route'

  enum movement_type: { walk: 0, bike: 1, car: 2 }
  enum record_status: { unpublished: 0, published: 1 }
end
