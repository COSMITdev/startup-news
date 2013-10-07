class News < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :title, :link, presence: true
  validates :link, url: true

  scope :newests, -> { order('created_at DESC')}
end
