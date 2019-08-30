# frozen_string_literal: true

class RemoveTypeIdFromRoutes < ActiveRecord::Migration[5.2]
  def change
    remove_column :routes, :type_id, :bigint
  end
end
