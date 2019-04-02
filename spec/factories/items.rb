FactoryBot.define do
  factory :item do
    item_type
    status { nil }
    title { 'Item padrão' }
    registry_number { '123456789' }
    brand
    model { 'Modelo padrão' }
    color { 'Cor padrão' }
    description { 'Descrição de item padrão' }
  end
end
