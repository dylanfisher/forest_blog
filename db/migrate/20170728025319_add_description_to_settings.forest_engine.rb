# This migration comes from forest_engine (originally 20170728025251)
class AddDescriptionToSettings < ActiveRecord::Migration[5.1]
  def change
    add_column :settings, :description, :text
  end
end
