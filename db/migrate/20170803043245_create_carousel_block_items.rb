class CreateCarouselBlockItems < ActiveRecord::Migration[5.1]
  def change
    create_table :carousel_block_items do |t|
      t.integer :image_id, index: true
      t.references :carousel_block, foreign_key: true

      t.timestamps
    end
  end
end
