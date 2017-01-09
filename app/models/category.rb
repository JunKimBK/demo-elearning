class Category < ApplicationRecord
  has_many :words, dependent: :destroy
  has_many :lessons, dependent: :destroy

  validates :name, presence: true, length: {maximum: 50, minimum: 3}
  mount_uploader :picture, PictureUploader
  accepts_nested_attributes_for :words
  validate  :picture_size

  scope :alphabetically, ->{order name: :asc}
  scope :search_name, ->name do
    where "name LIKE ?", "%#{name}%" if name.present?
  end

  private
  def picture_size
    if picture.size > Settings.user.size.image.megabytes
      errors.add :picture, I18n.t("should_be_less_than_5MB")
    end
  end
end
