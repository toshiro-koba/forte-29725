FactoryBot.define do
  factory :notification do
    visitor_id { Faker::Number.between(from: 1, to: 5) }
    visited_id { Faker::Number.between(from: 6, to: 10) }
    room_id { Faker::Number.between(from: 1, to: 5) }
    message_id { Faker::Number.between(from: 1, to: 5) }
    action { 'message' }
    checked { 0 }
  end
end
