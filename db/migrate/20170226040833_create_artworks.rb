class CreateArtworks < ActiveRecord::Migration[5.0]
  def change
    create_table :artworks do |t|
      t.string :title
      t.text :description
      t.date :date

      t.string :slug
      t.integer :status, default: 1, null: false

      t.timestamps
    end

    add_index :artworks, :slug, unique: true
    add_index :artworks, :status

  end
end
