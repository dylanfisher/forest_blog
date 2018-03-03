class CreateTextBlocks < ActiveRecord::Migration[5.1]
  def change
    create_table :text_blocks do |t|
      t.text :text
      t.timestamps
    end

    reversible do |change|
      change.up do
        unless BlockKind.find_by_name('TextBlock')
          BlockKind.create name: 'TextBlock',
                           category: 'Text',
                           description: 'A basic block for adding text to a page'
        end
      end

      change.down do
        BlockKind.where(name: 'TextBlock').destroy_all
      end
    end
  end
end
