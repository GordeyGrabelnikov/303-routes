# frozen_string_literal: true

class Point < ApplicationRecord
  belongs_to :user
  has_many :points_routes, dependent: :destroy
  has_many :routes, through: :points_routes
  has_many :comments, as: :commentable, dependent: :destroy

  has_many_attached :images

  validates :name, :description, :coordinates, presence: true
  validates :name, uniqueness: { scope: :coordinates, message: 'This point exist already' }

  enum record_status: { unpublished: 0, published: 1 }

  ratyrate_rateable 'name'
end
