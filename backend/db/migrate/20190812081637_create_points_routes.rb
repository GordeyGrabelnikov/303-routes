# frozen_string_literal: true

class CreatePointsRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :points_routes do |t|
      t.integer :point_id
      t.integer :route_id
    end
  end
end
