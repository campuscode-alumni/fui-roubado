FactoryBot.define do
  factory :item do
    item_type
    user
    status { nil }
    title { 'Item padrão' }
    sequence(:registry_number) { |n| "123456789#{n}" }
    brand
    model { 'Modelo padrão' }
    color { 'Cor padrão' }
    description { 'Descrição de item padrão' }
  end
end
