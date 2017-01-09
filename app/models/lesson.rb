class Lesson < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :words, through: :results

  accepts_nested_attributes_for :results
  before_create :make_random_words
  after_save :start_lesson_activity

  private
  def make_random_words
    self.word_ids = category.words.random
  end

  def start_lesson_activity
    Activity.create user_id: self.user_id, type_id: id,
      action_type: Activity.activity_types[:start_lesson]
  end
end
