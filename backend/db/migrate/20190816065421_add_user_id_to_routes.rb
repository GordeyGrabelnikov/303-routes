class AddUserIdToRoutes < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :routes, :user
  end
end
