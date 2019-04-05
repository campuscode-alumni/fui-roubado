FactoryBot.define do
  factory :report do
    item { nil }
    description { 'Assalto na rua' }
    ocurrance_date { "2019-04-03 19:40:50" }
    adress { 'r. do Ladrão, 666' }
  end
end
