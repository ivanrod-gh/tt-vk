require 'rails_helper'

RSpec.describe School, type: :model do
  it { should have_many(:klasses).dependent(:destroy) }
end
