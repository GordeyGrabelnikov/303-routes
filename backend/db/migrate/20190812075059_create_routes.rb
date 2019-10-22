# frozen_string_literal: true

class CreateRoutes < ActiveRecord::Migration[5.2]
  def change
    create_table :routes do |t|
      t.string :name
      t.string :route_type
      t.string :route_image_url

      t.timestamps
    end
  end
end
