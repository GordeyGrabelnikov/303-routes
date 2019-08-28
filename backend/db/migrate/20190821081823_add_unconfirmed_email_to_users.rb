# frozen_string_literal: true

class AddUnconfirmedEmailToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users,:unconfirmed_email, :string # Only if using reconfirmable
  end
end
