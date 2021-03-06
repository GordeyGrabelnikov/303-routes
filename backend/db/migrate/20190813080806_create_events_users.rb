# frozen_string_literal: true

class CreateEventsUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :events_users do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end
  end
end
