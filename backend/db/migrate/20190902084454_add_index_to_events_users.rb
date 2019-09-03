class AddIndexToEventsUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :events_users, [:event_id, :user_id]
    add_index :events_users, :role
  end
end
