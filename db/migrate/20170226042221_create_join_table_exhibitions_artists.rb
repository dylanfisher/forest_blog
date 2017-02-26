class CreateJoinTableExhibitionsArtists < ActiveRecord::Migration[5.0]
  def change
    create_join_table :exhibitions, :artists do |t|
      t.index [:exhibition_id, :artist_id]
      t.index [:artist_id, :exhibition_id]
    end
  end
end
