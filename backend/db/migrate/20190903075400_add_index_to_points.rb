class AddIndexToPoints < ActiveRecord::Migration[5.2]
  def change
    add_index :points, :name
    add_index :points, :tags
    add_index :points, :coordinates
  end
end
