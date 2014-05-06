class News < ActiveRecord::Base
  include Rankable
  extend FriendlyId
  friendly_id :title, use: :slugged

  belongs_to :user
  has_many :votes, dependent: :destroy

  validates :user_id, :title, :link, presence: true
  validates :link, url: true

  scope :newests, -> { order('created_at DESC') }

  def should_generate_new_friendly_id?
    new_record? || slug.blank?
  end
end
