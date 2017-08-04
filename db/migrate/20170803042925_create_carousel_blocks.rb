class CreateCarouselBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :carousel_blocks do |t|
      t.timestamps
    end

    reversible do |change|
      change.up do
        unless BlockType.find_by_name('CarouselBlock')
          BlockType.create name: 'CarouselBlock',
                           category: 'default',
                           description: ''
        end
      end

      change.down do
        BlockType.where(name: 'CarouselBlock').destroy_all
        BlockSlot.where(block_type: 'CarouselBlock').destroy_all
      end
    end
  end
end
