module Rankable
  extend ActiveSupport::Concern

  included do
    after_create :update_rank

    scope :by_ranking, -> { order('rank DESC') }
  end

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
    update_attribute(:rank, new_rank_value)
  end

  private

  def new_rank_value
    difference = up - down
    epoch_seconds = (created_at.to_i - DateTime.new(2005, 12, 8, 7, 46, 43).to_time.to_i).to_f
    (displacement(difference) * sign(difference)) + (epoch_seconds / 45000)
  end

  def displacement(difference)
    Math.log([difference.abs, 1].max, 10)
  end

  def sign(difference)
    difference > 0 ? 1.0 : difference < 0 ? -1.0 : 0.0
  end
end
