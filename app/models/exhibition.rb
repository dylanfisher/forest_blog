class Exhibition < Forest::ApplicationRecord
  include FilterModelScopes
  include Blockable
  include Searchable
  include Statusable

  # has_paper_trail

  before_validation :generate_slug

  validates :slug, presence: true, uniqueness: true

  has_one :current_version, -> { reorder(created_at: :desc, id: :desc) }, class_name: "PaperTrail::Version", foreign_key: 'item_id'
  has_one :current_published_version, -> { reorder(created_at: :desc, id: :desc).where_object(status: 1) }, class_name: "PaperTrail::Version", foreign_key: 'item_id'

  has_and_belongs_to_many :artists
  has_and_belongs_to_many :artworks

  scope :title_or_id_like, -> string { where('exhibitions.title ILIKE ? OR exhibitions.id = ?', "%#{string}%", string.to_i) }

  def to_label
    "#{id} - #{title}"
  end

  def generate_slug
    self.slug = title.parameterize unless attribute_present?('slug')
  end

  def to_param
    slug
  end
end
