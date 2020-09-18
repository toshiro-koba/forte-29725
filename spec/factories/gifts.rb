FactoryBot.define do
  factory :gift do
    price { Faker::Number.between(from: 300, to: 99_999) }
    token { "tok_#{Faker::Alphanumeric.alphanumeric(number: 28)}" }
    # user_id { "1" }
    # giver_id { "2" }
    # association :giftings
    # association :receivings
    # association :giver, class: User
    # association :user, class: User
  end
end

# has_many :gifts
#   has_many :giftings, through: :gifts, source: :giver
#   has_many :reverse_of_gifts, class_name: 'Gift', foreign_key: 'giver_id'
#   has_many :receivings, through: :reverse_of_gifts, source: :user
