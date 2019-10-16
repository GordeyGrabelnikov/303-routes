class FixColomnName < ActiveRecord::Migration[5.2]
  def self.up
    #Comments
    rename_column :comments, :comment, :body
    #Events
    rename_column :events, :event_name, :name
    rename_column :events, :event_description, :description
    rename_column :events, :event_date, :date
    rename_column :events, :event_status, :record_status
    #Points
    rename_column :points, :point_status, :record_status
    #Routes
    rename_column :routes, :route_status, :record_status
    rename_column :routes, :route_image_url, :image_url
    rename_column :routes, :route_type, :movement_type
    #Users
    rename_column :users, :user_image_url, :avatar
    rename_column :users, :user_role, :role
  end

  def self.down
    # rename back if you need or do something else or do nothing
    rename_column :comments,:body, :comment
    rename_column :events, :name, :event_name
    rename_column :events, :description,  :event_description
    rename_column :events, :date, :event_date
    rename_column :events, :record_status, :event_status
    rename_column :points, :record_status, :point_status
    rename_column :routes, :record_status, :route_status
    rename_column :routes, :movement_type, :route_type
    rename_column :routes, :image_url, :route_image_url
    rename_column :users, :avatar, :user_image_url
    rename_column :users, :role, :user_role
  end
end
