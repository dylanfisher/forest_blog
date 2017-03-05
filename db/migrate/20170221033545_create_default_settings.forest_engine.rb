# This migration comes from forest_engine (originally 20161219045555)
class CreateDefaultSettings < ActiveRecord::Migration[5.0]
  def up
    Setting.find_or_create_by title: 'Site Title', value: 'Default Site Title'
    Setting.find_or_create_by title: 'Description', value: 'A Site Built With Forest'
    Setting.find_or_create_by title: 'Featured Image', value: nil, value_type: 'image'
  end
end