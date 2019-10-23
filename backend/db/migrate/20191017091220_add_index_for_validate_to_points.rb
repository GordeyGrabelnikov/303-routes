# frozen_string_literal: true

class AddIndexForValidateToPoints < ActiveRecord::Migration[5.2]
  def change
    add_index :points, %i[name coordinates], unique: true
  end
end
