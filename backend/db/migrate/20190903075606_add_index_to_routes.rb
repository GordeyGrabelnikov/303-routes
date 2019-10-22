# frozen_string_literal: true

class AddIndexToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_index :routes, :name
    add_index :routes, :route_type
  end
end
