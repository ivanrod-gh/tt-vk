require 'rails_helper'

RSpec.describe Klass, type: :model do
  it { should belong_to :school }
  it { should have_many(:students).dependent(:destroy) }
  
  it { should validate_presence_of :number }
  it { should validate_presence_of :letter }
  it { should validate_presence_of :students_count }
end
