# frozen_string_literal: true

class AddRouteTypeToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_column :routes, :route_type, :integer, default: 0
  end
end
