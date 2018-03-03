class CreateTitleBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :title_blocks do |t|
      t.string :title
      t.timestamps
    end

    reversible do |change|
      change.up do
        unless BlockKind.find_by_name('TitleBlock')
          BlockKind.create name: 'TitleBlock',
                           category: 'Text',
                           description: 'Add a title to a page'
        end
      end

      change.down do
        BlockKind.where(name: 'TitleBlock').destroy_all
      end
    end
  end
end
