# frozen_string_literal: true

class CreatePoints < ActiveRecord::Migration[5.2]
  def change
    create_table :points do |t|
      t.string :name
      t.text :description
      t.string :tag
      t.string :image_url
      t.string :coordinates

      t.timestamps
    end
  end
end
