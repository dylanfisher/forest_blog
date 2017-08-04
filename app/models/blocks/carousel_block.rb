class CarouselBlock < BaseBlock
  has_many :carousel_block_items
  accepts_nested_attributes_for :carousel_block_items, reject_if: :all_blank, allow_destroy: true

  # TODO: DF 08/04/17 - Need to add position field and make cocoons sortable

  def self.permitted_params
    [carousel_block_items_attributes: [:id, :_destroy, :image_id]]
  end

  def self.display_name
    'Carousel Block'
  end

  def self.display_icon
    'glyphicon glyphicon-picture'
  end
end
