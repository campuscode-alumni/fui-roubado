FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "Dom Pedro #{n}" }
    sequence(:nickname) { |n| "pedroca#{n}" }
    sequence(:email) { |n| "pedro#{n}@email.com" }
    password { '123456' }
    cpf { '352.374.450-47' }
    city
  end
end
