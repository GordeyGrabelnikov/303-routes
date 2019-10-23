# frozen_string_literal: true

class AddIndexForValidateToEvents < ActiveRecord::Migration[5.2]
  def change
    add_index :events, %i[name date route_id], unique: true
  end
end
