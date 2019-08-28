class PointsRoute < ActiveRecord::Base
  belongs_to :point
  belongs_to :route

  validates :point_id, uniqueness: { scope: :route_id }
end