class School < ApplicationRecord
  has_many :klasses, dependent: :destroy
end
