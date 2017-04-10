# This migration comes from forest_engine (originally 20170410173713)
class AddPathToPages < ActiveRecord::Migration[5.0]
  def change
    add_column :pages, :path, :text
    add_index :pages, :path, unique: true
  end
end
