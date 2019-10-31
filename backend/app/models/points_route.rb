# frozen_string_literal: true

class PointsRoute < ApplicationRecord
  belongs_to :point, primary_key: :google_point_id
  belongs_to :route

  validates :point_id, uniqueness: { scope: :route_id }
end
