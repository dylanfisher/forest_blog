# This migration comes from forest (originally 20170219030925)
class AddValueTypeToSettings < ActiveRecord::Migration[5.0]
  def change
    add_column :settings, :value_type, :string, default: 'text'
  end
end
