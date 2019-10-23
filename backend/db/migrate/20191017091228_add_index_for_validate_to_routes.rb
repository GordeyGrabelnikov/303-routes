# frozen_string_literal: true

class AddIndexForValidateToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_index :routes, %i[name movement_type], unique: true
  end
end
