FactoryBot.define do
  factory :report do
    user
    description { 'Assalto na rua' }
    ocurrance_date { '2019-04-03 19:40:50' }
    address { 'r. do Ladrão, 666' }
  end
end
