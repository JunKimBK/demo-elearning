class Word < ApplicationRecord

  belongs_to :category, optional: true
  has_many :results, dependent: :destroy
  has_many :meanings, dependent: :destroy, inverse_of: :word
  has_many :lessons, through: :results

  accepts_nested_attributes_for :meanings, allow_destroy: true

  validates :content, presence: true, length: {maximum: Settings.user.word.maximum}
  accepts_nested_attributes_for :results

  scope :of_category, ->category_id do
    where category_id: category_id if category_id.present?
  end
  scope :learned, ->current_user_id do
    where "id IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = ?))", current_user_id
  end
  scope :not_learned, ->current_user_id do
    where "id NOT IN (SELECT word_id FROM results WHERE lesson_id IN
      (SELECT id FROM lessons WHERE user_id = ?))", current_user_id
  end
  scope :get_all, ->current_user_id{}
  scope :random, ->{order("RANDOM()").limit(5).map(&:id)}
  scope :create_day, ->{order created_at: :desc}

  validate :check_meaning_nil

  private
  def check_meaning_nil
    correct_meaning =
      meanings.select{|meanings|meanings.is_correct? && !meanings.marked_for_destruction?}
    errors.add :correct_meaning,
      I18n.t("meaning_nil") if correct_meaning.empty?
  end
end
