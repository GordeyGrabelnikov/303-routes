class AddIndexToPointsRoutes < ActiveRecord::Migration[5.2]
  def change
    add_index :points_routes, %i[point_id route_id]
  end
end
