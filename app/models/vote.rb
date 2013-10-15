class Vote < ActiveRecord::Base
  after_create :update_news_rank

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
    new_rate = is_up? ? :down : :up
    update_attribute(:is_up, !is_up?) && news.change_existing_rate_to(new_rate)
  end

  class << self
    def find_user_for_news(user, news)
      where(user: user, news: news).first
    end

    def find_ip_for_news(ip, news)
      where(ip: ip, news: news).first
    end
  end

  private

  def update_news_rank
    news.__send__(rate_method)
  end

  def rate_method
    is_up? ? :rate_up : :rate_down
  end
end
