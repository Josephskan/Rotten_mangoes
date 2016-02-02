class Movie < ActiveRecord::Base

  has_many :reviews

  mount_uploader :upload_movie_image, ImageUploader

  validates :title, presence: true
  validates :director, presence: true
  validates :runtime_in_minutes, presence: true, numericality: { only_integer: true }
  validates :release_date, presence: true
  # validates :poster_image_url, presence: true
  validates :description, presence: true
  validate  :release_date_is_in_the_past
  validate  :image_upload_or_url

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

  def image_upload_or_url
    if release_date.present? || upload_movie_image.present?
      errors.add(:poster_image_url, "Must give a url image link or upload an image") if !release_date || !upload_movie_image
    end
  end
end