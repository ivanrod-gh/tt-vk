FactoryBot.define do
  factory :student do
    klass

    first_name { 'имя' }
    last_name { 'фамилия' }
    sur_name { 'отество' }
  end
end
