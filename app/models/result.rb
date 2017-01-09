class Result < ApplicationRecord
  belongs_to :lesson
  belongs_to :word
  belongs_to :meaning

  scope :choosen_word, ->do
    joins(:meaning).where "meaning_id <> ''"
  end
  scope :choosen_word_correct, ->do
    joins(:meaning).where "meanings.is_correct = ?", true
  end
end
