class Student < ApplicationRecord
  belongs_to :klass

  validates :first_name, :last_name, :sur_name, presence: true

  after_create :count_student
  after_destroy :count_student

  private

  def count_student
    klass.update(students_count: klass.students.count)
  end
end
