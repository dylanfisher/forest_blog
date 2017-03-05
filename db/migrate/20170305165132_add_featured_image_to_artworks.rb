class AddFeaturedImageToArtworks < ActiveRecord::Migration[5.0]
  def change
    add_reference :artworks, :featured_image
  end
end
