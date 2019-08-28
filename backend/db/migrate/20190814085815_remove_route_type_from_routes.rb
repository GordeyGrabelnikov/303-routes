class RemoveRouteTypeFromRoutes < ActiveRecord::Migration[5.2]
  def change
    remove_column :routes, :route_type, :string
  end
end
