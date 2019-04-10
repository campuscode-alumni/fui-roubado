FactoryBot.define do
  factory :item_found do
    item { nil }
    message { 'Seu notebook esta sendo vendido por ai' }
    email { 'email@email.com' }
  end
end
