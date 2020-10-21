FactoryBot.define do
  factory :gift do
    price { Faker::Number.between(from: 300, to: 50000) }
    token { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
  end
end

