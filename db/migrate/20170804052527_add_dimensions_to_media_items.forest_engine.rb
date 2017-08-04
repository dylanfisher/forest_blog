# This migration comes from forest_engine (originally 20170804052457)
class AddDimensionsToMediaItems < ActiveRecord::Migration[5.1]
  def change
    add_column :media_items, :dimensions, :text
  end
end
