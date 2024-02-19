
Faker::Config.locale = :ru

3.times { School.create }

Klass.create(number: 1, letter: 'А', school: School.first)
Klass.create(number: 5, letter: 'А', school: School.first)
Klass.create(number: 9, letter: 'А', school: School.first)

Klass.create(number: 3, letter: 'А', school: School.second)
Klass.create(number: 6, letter: 'А', school: School.second)
Klass.create(number: 6, letter: 'Б', school: School.second)
Klass.create(number: 8, letter: 'А', school: School.second)
Klass.create(number: 8, letter: 'Б', school: School.second)
Klass.create(number: 8, letter: 'В', school: School.second)

Klass.create(number: 2, letter: 'А', school: School.last)
Klass.create(number: 4, letter: 'А', school: School.last)
Klass.create(number: 10, letter: 'А', school: School.last)
Klass.create(number: 10, letter: 'Б', school: School.last)

Klass.all.each do |klass|
  rand(10..20).times do
    full_names = ['имя', 'отчество', 'фамилия']
    99.times do
      full_names = Faker::Name.name.split(' ')
      break if full_names.count == 3
    end
    klass.students.create(first_name: full_names.first, last_name: full_names.last, sur_name: full_names.second)
  end
end
