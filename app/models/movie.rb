class Movie < ActiveRecord::Base

  has_many :reviews

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, presence: true, numericality: { only_integer: true }
  validates :release_date, presence: true
  validates :poster_image_url, presence: true
  validates :description, presence: true
  validate  :release_date_is_in_the_past

  def review_average
    return 0 unless reviews.size > 0
      reviews.sum(:rating_out_of_ten)/reviews.size
  end

  private

  def release_date_is_in_the_past
    if release_date.present?
      errors.add(:release_date, "should be in the past") if release_date > Date.today
    end
  end
end