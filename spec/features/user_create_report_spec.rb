require 'rails_helper'

feature 'User create report' do
  scenario 'successfully' do
    pending
    user = create(:user)
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, title: 'item1', registry_number: '12345678910', status: :stolen,
                  item_type: item_type, user: user)
    create(:item, title: 'item2', registry_number: 'abcd', status: :owned,
                  item_type: item_type, user: user)
    create(:item, title: 'item3', registry_number: 'zxcv', status: :owned,
                  item_type: item_type2, user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Criar relatório'
    fill_in 'Endereço', with: 'Rua Alemada Santos, 1293'
    select 'Data da Ocorrência', with: '02/04/2019'
    select 'Horário', with: '20:00hs'
    fill_in 'Descrição do ocorrido', with: ''
    fill_in 'Boletim de Ocorrência', with: ''
    
    check ''

  end
end