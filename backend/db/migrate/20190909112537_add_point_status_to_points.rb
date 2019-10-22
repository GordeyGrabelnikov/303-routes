class AddPointStatusToPoints < ActiveRecord::Migration[5.2]
  def change
    add_column :points, :point_status, :integer, null: false, default: 0
  end
end
