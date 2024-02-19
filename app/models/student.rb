class Student < ApplicationRecord
  belongs_to :klass

  validates :first_name, :last_name, :sur_name, presence: true
end
