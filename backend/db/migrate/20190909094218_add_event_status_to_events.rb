class AddEventStatusToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_status, :integer, null: false, default: 0
  end
end
