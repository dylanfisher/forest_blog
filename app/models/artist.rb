class Artist < ApplicationRecord
  include FilterModelScopes
  include Blockable
  include Searchable
  include Statusable

  extend FriendlyId
  friendly_id :name, use: :slugged

  has_paper_trail

  has_one :current_version, -> { reorder(created_at: :desc, id: :desc) }, class_name: "PaperTrail::Version", foreign_key: 'item_id'
  has_one :current_published_version, -> { reorder(created_at: :desc, id: :desc).where_object(status: 1) }, class_name: "PaperTrail::Version", foreign_key: 'item_id'

  has_and_belongs_to_many :artworks
  has_and_belongs_to_many :exhibitions

  validates :last_name, presence: true

  scope :by_name, -> (orderer = :asc) { order(last_name: orderer, first_name: orderer, id: :desc) }
  scope :name_or_id_like, -> string { where('(artists.first_name || ' ' || artists.last_name) ILIKE ? OR artists.id = ?', "%#{string}%", string.to_i) }

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  def to_label
    "#{id} - #{name}"
  end

  private

    def should_generate_new_friendly_id?
      slug.blank?
    end
end
