require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should belong_to :klass }

  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :sur_name }
end
