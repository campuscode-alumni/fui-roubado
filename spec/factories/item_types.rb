FactoryBot.define do
  factory :item_type do
    sequence(:name) { |n| "Tipo#{n}" }
  end
end
