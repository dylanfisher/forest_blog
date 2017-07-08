# This migration comes from forest_engine (originally 20170705034957)
class AddScheduledDateToPage < ActiveRecord::Migration[5.1]
  def change
    add_column :pages, :scheduled_date, :datetime
  end
end
