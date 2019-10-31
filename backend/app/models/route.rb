# frozen_string_literal: true

class Route < ApplicationRecord
  belongs_to :user
  has_many :events, dependent: :nullify
  has_many :points_routes, dependent: :destroy
  has_many :points, -> { order('points_routes.id') }, through: :points_routes
  has_many :comments, as: :commentable, dependent: :destroy

  has_many_attached :route_images

  validates :name, presence: true
  validates :name, uniqueness: { scope: :movement_type, message: 'A route with the same name already exists.' }

  ratyrate_rateable 'route'

  enum movement_type: { WALKING: 0, BICYCLING: 1, DRIVING: 2 }
  enum record_status: { unpublished: 0, published: 1 }
end
