# This migration comes from forest_engine (originally 20170225184951)
class AddParentPageToPages < ActiveRecord::Migration[5.0]
  def change
    add_reference :pages, :parent_page
  end
end
