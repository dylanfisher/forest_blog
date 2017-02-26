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

  def name
    [first_name, last_name].reject(&:blank?).join(' ')
  end

  private

    def should_generate_new_friendly_id?
      slug.blank?
    end
end
