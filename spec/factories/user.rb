FactoryBot.define do
  factory :user do
    name { Faker::JapaneseMedia::OnePiece.character }
    email { Faker::Internet.email }
    role { 'student' }
    birth_date { Faker::Date.backward(days: rand(1000..9999)) }
  end

  trait :teacher do
    role { 'teacher' }
  end
end
