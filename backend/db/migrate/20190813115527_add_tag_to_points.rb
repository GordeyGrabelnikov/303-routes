# frozen_string_literal: true

class AddTagToPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :tags, :jsonb, null: false, default: '[]'
  end
end
