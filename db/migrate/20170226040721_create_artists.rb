class CreateArtists < ActiveRecord::Migration[5.0]
  def change
    create_table :artists do |t|
      t.string :first_name
      t.string :last_name
      t.text :bio

      t.string :slug
      t.integer :status, default: 1, null: false

      t.timestamps
    end

    add_index :artists, :slug, unique: true
    add_index :artists, :status

  end
end
