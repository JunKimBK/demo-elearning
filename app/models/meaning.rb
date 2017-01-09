class Meaning < ApplicationRecord
  belongs_to :word, inverse_of: :meanings
  has_many :results
  has_many :lessons, through: :results
  accepts_nested_attributes_for :results
  validates :content, presence: true, length: {maximum: 50}
end
