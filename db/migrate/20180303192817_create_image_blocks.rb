class CreateImageBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :image_blocks do |t|
      t.references :media_item, foreign_key: true, index: true
      t.timestamps
    end

    reversible do |change|
      change.up do
        unless BlockKind.find_by_name('ImageBlock')
          BlockKind.create name: 'ImageBlock',
                           category: 'Media',
                           description: 'Display an image'
        end
      end

      change.down do
        BlockKind.where(name: 'ImageBlock').destroy_all
      end
    end
  end
end
