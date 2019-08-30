# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.text :comment
      t.references :commentable, polymorphic: true, index: true
      t.timestamps
    end
    add_belongs_to :comments, :user
  end
end
