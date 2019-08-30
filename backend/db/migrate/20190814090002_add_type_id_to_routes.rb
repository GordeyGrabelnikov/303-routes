# frozen_string_literal: true

class AddTypeIdToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :routes, :type
  end
end
