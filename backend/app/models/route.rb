# frozen_string_literal: true

class Route < ApplicationRecord
  enum route_type: %i[walk bike car]
  belongs_to :user
  has_many :points_routes, dependent: :destroy
  has_many :points, through: :points_routes
  has_many :events
  has_many :comments, as: :commentable, dependent: :destroy

  validates :name, presence: true
end
