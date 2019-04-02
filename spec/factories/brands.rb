FactoryBot.define do
  factory :brand do
    sequence(:name) { |n| "Marca#{n}" }
    item_type
  end
end
