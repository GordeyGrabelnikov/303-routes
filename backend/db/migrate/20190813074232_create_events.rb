class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.integer :route_id
      t.string :event_name
      t.text :event_description
      t.date :event_date

      t.timestamps
    end
  end
end
