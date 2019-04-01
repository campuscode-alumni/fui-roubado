FactoryBot.define do
  factory :city do
    sequence(:name) { |n| "Cidade Padrão #{n}" }
  end
end
