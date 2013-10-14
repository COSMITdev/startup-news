class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :news

  validates :ip, :news, presence: true
  validates :is_up, inclusion: { in: [true, false] }

  def up?
    is_up?
  end

  def down?
    !is_up?
  end

  def change_vote
    update_attribute(:is_up, !is_up?)
  end

  class << self
    def find_user_for_news(user, news)
      where(user: user, news: news).first
    end

    def find_ip_for_news(ip, news)
      where(ip: ip, news: news).first
    end
  end
end
