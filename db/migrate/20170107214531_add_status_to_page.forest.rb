# This migration comes from forest (originally 20161227212941)
class AddStatusToPage < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :status, :integer, default: 1, null: false
    add_index :pages, :status
  end
end
