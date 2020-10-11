FactoryBot.define do
  factory :relationship do
    association :user
    association :follow, class: User
  end
end
