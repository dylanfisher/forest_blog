class CarouselBlockItem < ApplicationRecord
  belongs_to :image, class_name: 'MediaItem'
  belongs_to :carousel_block
end
