# frozen_string_literal: true

class School < ApplicationRecord
  has_many :klasses, dependent: :destroy
end
