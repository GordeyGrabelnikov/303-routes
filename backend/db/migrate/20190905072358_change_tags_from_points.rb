# frozen_string_literal: true

class ChangeTagsFromPoints < ActiveRecord::Migration[5.2]
  def self.up
    change_column :points, :tags, :jsonb, null: false, default: []
  end

  def self.down
    change_column :points, :tags, :jsonb, null: false, default: '[]'
  end
end
