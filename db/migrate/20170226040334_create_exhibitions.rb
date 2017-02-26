class CreateExhibitions < ActiveRecord::Migration[5.0]
  def change
    create_table :exhibitions do |t|
      t.string :title
      t.text :description
      t.date :start_date
      t.date :end_date

      t.string :slug
      t.integer :status, default: 1, null: false

      t.timestamps
    end

    add_index :exhibitions, :slug, unique: true
    add_index :exhibitions, :status

  end
end
