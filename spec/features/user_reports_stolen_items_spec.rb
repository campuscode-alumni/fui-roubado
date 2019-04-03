require 'rails_helper'

feature 'User reports stolen items' do
  scenario 'successfully' do
    user = create(:user)
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, title: 'Notebook Dell', registry_number: '12345678910', status: :stolen,
                  item_type: item_type, user: user)
    create(:item, title: 'Smartphone Samsung', registry_number: 'abcd', status: :owned,
                  item_type: item_type2, user: user)
    create(:item, title: 'Smartphone Motorola', registry_number: 'zxcv', status: :owned,
                  item_type: item_type2, user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Fui roubado!'
    fill_in 'Endereço', with: 'Rua Alemada Santos, 1293'
    # select 'Data da Ocorrência'
    # select 'Horário'
    fill_in 'Descrição do ocorrido', with: 'Assalto a mão armada no ponto de ônibus'
    attach_file 'Boletim de ocorrência', Rails.root.join('spec', 'support',
                                         'boletim_de_ocorrencia.jpg') 
    check 'Notebook Dell'
    check 'Smartphone Samsung'
    click_on 'Reportar'

    expect(current_path).to eq report_path(1)
    expect(page).to have_css('h2', text: 'Rua Alemada Santos, 1293')
    expect(page).to have_css('h3', text: 'Data/hora: 22/03/2019 18:30')
    expect(page).to have_css('img[src*="boletim_de_ocorrencia.jpg"]')
    expect(page).to have_ccs('p', text: 'Assalto a mão armada no ponto de ônibus')
    expect(page).to have_ccs('p', text: 'Notebook Dell')
    expect(page).to have_ccs('p', text: 'Smartphone')
    expect(page).not_to have_ccs('p', text: 'Smartphone Samsung')
  end
end