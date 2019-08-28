class AddRoleToEventsUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :events_users, :role, :integer, default: 0
  end
end
