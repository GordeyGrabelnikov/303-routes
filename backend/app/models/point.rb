# frozen_string_literal: true

class Point < ApplicationRecord
  has_many :points_routes
  has_many :routes, through: :points_routes
  has_many :comments, as: :commentable, dependent: :destroy

  has_many_attached :images

  validates :name, :description, :coordinates, presence: true
end
