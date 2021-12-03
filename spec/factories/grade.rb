FactoryBot.define do
  factory :grade do
    code { Faker::JapaneseMedia::SwordArtOnline.location }
    year { Faker::Date.in_date_period.year }
    hour_start { Time.now.strftime('%H:%M') }
    hour_end { (Time.now + 4.hours).strftime('%H:%M') }
    school_name { Faker::JapaneseMedia::SwordArtOnline.location }
    sunday { [false, true].sample }
    monday { false }
    tuesday { false }
    wednesday { false }
    thursday { false }
    friday { [false, true].sample }
    saturday { false }
  end
end
