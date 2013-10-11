class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :news

  validates :user_id, :news_id, :text, presence: true
end
