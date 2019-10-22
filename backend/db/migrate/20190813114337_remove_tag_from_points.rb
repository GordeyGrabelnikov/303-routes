# frozen_string_literal: true

class RemoveTagFromPoints < ActiveRecord::Migration[5.2]
  def change
    remove_column :points, :tag, :string
  end
end
