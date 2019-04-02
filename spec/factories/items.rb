FactoryBot.define do
  factory :item do
    item_type { nil }
    status { nil }
    title { "MyString" }
    registry_number { "MyString" }
    brand { nil }
    model { "MyString" }
    color { "MyString" }
    description { "MyText" }
  end
end
