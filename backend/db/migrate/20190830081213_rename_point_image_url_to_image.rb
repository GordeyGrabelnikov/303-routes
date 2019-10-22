# frozen_string_literal: true

class RenamePointImageUrlToImage < ActiveRecord::Migration[5.2]
  def change
    rename_column :points, :image_url, :image
  end
end
