class DropSearches < ActiveRecord::Migration[5.2]
  def up
    drop_table :searches
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
