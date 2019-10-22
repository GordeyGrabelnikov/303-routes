class AddUserRoleToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :user_role, :integer, null: false, default: 0
  end
end
