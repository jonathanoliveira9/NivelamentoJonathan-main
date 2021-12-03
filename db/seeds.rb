# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

## Populate seeds
puts 'Creating teachers'

10.times do |_|
  User.create(name: Faker::Name.name,
              birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
              email: Faker::Internet.email).teacher!
end

puts 'Creating students'

100.times do |_|
  User.create(name: Faker::Name.name,
              birth_date: Faker::Date.birthday(min_age: 18, max_age: 65),
              email: Faker::Internet.email).student!
end

puts 'Creating Grades'
10.times do |_|
  Grade.create(code: Faker::JapaneseMedia::OnePiece.island,
               year: Time.now.year,
               hour_start: Time.now.strftime('%H:%M'),
               hour_end: (Time.now + 4.hours).strftime('%H:%M'),
               school_name: Faker::JapaneseMedia::OnePiece.location,
               sunday: [false, true].sample,
               monday: false,
               tuesday: false,
               wednesday: false,
               thursday: false,
               friday: [false, true].sample,
               saturday: false)
end
