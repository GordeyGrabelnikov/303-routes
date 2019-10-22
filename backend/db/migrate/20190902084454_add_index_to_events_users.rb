# frozen_string_literal: true

class AddIndexToEventsUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :events_users, %i[event_id user_id]
    add_index :events_users, :role
  end
end
