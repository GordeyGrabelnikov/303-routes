class AddIndexToEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :events, :route_id
    add_index :events, :event_name
  end
end
