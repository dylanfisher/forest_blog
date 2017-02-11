# This migration comes from forest (originally 20170102201015)
class AddFeaturedImageToPages < ActiveRecord::Migration[5.0]
  def change
    add_reference :pages, :featured_image
  end
end
