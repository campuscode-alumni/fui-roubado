require 'rails_helper'

feature 'User reports stolen items' do
  scenario 'successfully' do
    user = create(:user)
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, title: 'Notebook Dell', registry_number: '12345678910',
                  status: :stolen,
                  item_type: item_type, user: user)
    create(:item, title: 'Smartphone Samsung', registry_number: 'abcd',
                  status: :owned,
                  item_type: item_type2, user: user)
    create(:item, title: 'Smartphone Motorola', registry_number: 'zxcv',
                  status: :owned, item_type: item_type2, user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Reportar roubo'
    fill_in 'Endereço', with: 'Rua Alemada Santos, 1293'
    select '2', from: 'report_ocurrance_date_3i'
    select 'Janeiro', from: 'report_ocurrance_date_2i'
    select '2019', from: 'report_ocurrance_date_1i'
    select '20', from: 'report_ocurrance_date_4i'
    select '00', from: 'report_ocurrance_date_5i'
    fill_in 'Descrição do ocorrido', with: 'Assalto a mão armada'\
                                           ' no ponto de ônibus'
    attach_file 'Boletim de ocorrência',
                Rails.root.join('spec', 'support', 'boletim_de_ocorrencia.jpg')
    check 'Notebook Dell'
    check 'Smartphone Samsung'
    click_on 'Reportar'

    expect(current_path).to eq report_path(1)
    expect(page).to have_css('h1', text: 'Rua Alemada Santos, 1293')
    expect(page).to have_css('h2', text: '2019-01-02 20:00:00')
    expect(page).to have_css('p', text: 'Assalto a mão armada'\
                                        ' no ponto de ônibus')
    expect(page).to have_css('li', text: 'Notebook Dell')
    expect(page).to have_css('li', text: 'Smartphone')
    expect(page).not_to have_css('p', text: 'Smartphone Samsung')
    expect(page).to have_css('img[src*="boletim_de_ocorrencia.jpg"]')
    expect(page).not_to have_css('Não foi possível criar o relatório')
  end

  scenario 'and must fill address, date/time and have at least one item' do
    user = create(:user)
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, title: 'Notebook Dell', registry_number: '12345678910',
                  status: :stolen,
                  item_type: item_type, user: user)
    create(:item, title: 'Smartphone Samsung', registry_number: 'abcd',
                  status: :owned,
                  item_type: item_type2, user: user)
    create(:item, title: 'Smartphone Motorola', registry_number: 'zxcv',
                  status: :owned, item_type: item_type2, user: user)
    login_as user, scope: :user

    visit new_report_path
    fill_in 'Endereço', with: ''
    fill_in 'Descrição do ocorrido', with: ''
    click_on 'Reportar'

    expect(page).to have_content('Não foi possível criar o relatório')
    expect(page).to have_content('Endereço não pode ficar em branco')
    expect(page).to have_content('Items não pode ficar em branco')
  end
end
