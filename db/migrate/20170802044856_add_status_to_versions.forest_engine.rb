# This migration comes from forest_engine (originally 20170802044449)
class AddStatusToVersions < ActiveRecord::Migration[5.1]
  def change
    add_column :versions, :status, :integer
    add_index :versions, :status
  end
end
