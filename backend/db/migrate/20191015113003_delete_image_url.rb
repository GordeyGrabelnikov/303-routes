class DeleteImageUrl < ActiveRecord::Migration[5.2]
  def up
    remove_column :points, :image
    remove_column :routes, :image_url
    remove_column :users, :avatar

  end

  def down
    add_column :points, :image, :varchar
    add_column :routes, :image_url, :varchar
    add_column :users, :avatar, :varchar
  end
end
