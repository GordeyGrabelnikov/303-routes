class AddStatusToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :route_status, :integer, null: false, default: 0
  end
end
