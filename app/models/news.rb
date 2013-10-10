class News < ActiveRecord::Base
  belongs_to :user

  validates :user_id, :title, :link, presence: true
  validates :link, url: true

  scope :newests, -> { order('created_at DESC') }
  scope :by_ranking, -> { order('rank DESC') }

  def rate_up
    update_attribute(:up, up + 1) and update_rank
  end

  def rate_down
    update_attribute(:down, down + 1) and update_rank
  end

  def change_existing_rate_to(key = :up)
    if key == :up
      update_attribute(:down, down - 1)
      rate_up
    elsif key == :down
      update_attribute(:up, up - 1)
      rate_down
    end
  end

  def update_rank
    difference_between_up_and_down = up - down
    displacement = Math.log([difference_between_up_and_down.abs, 1].max, 10)

    sign = if difference_between_up_and_down > 0
      1
    elsif difference_between_up_and_down < 0
      -1
    else
      0
    end
    epoch_seconds = (created_at.to_i - Time.local(2005, 12, 8, 7, 46, 43).to_time.to_i).to_f
    ranking = (displacement * sign.to_f) + ( epoch_seconds / 45000)
    update_attribute(:rank, ranking)
  end
end
