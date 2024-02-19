class Klass < ApplicationRecord
  belongs_to :school
  has_many :students, dependent: :destroy

  validates :number, :letter, :students_count, presence: true
  validates :number, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 11 }
  validate :validate_letter

  private

  def validate_letter
    errors.add(:letter, "is invalid") unless letter =~ /[а-яА-Я]/
  end
end
