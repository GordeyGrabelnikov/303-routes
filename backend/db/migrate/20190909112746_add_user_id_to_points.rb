class AddUserIdToPoints < ActiveRecord::Migration[5.2]
  def change
    add_belongs_to :points, :user
  end
end
