class CreateJoinTableExhibitionsArtworks < ActiveRecord::Migration[5.0]
  def change
    create_join_table :exhibitions, :artworks do |t|
      t.index [:exhibition_id, :artwork_id]
      t.index [:artwork_id, :exhibition_id]
    end
  end
end
