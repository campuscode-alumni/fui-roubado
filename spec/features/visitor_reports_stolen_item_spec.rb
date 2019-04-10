require 'rails_helper'

feature 'Visitor reports stolen item' do
  scenario 'successfully' do
    item_type = create(:item_type, name: 'Smartphone')
    create(:item, registry_number: '12345678910', status: :stolen,
                  item_type: item_type)

    visit root_path

    select 'Smartphone', from: 'Tipo'
    fill_in 'Número de registro', with: '12345678910'
    click_on 'Buscar'

    fill_in 'Paradeiro do item:', with: 'Achei seu celular sendo vendido na OLX'
    click_on 'Enviar para o proprietário'

    expect(page).to have_content('Obrigado!')
    expect(page).to have_content('Enviamos sua mensagem para o dono do '\
                                 'Smartphone código 12345678910')
  end

  scenario 'and must fill in message' do
    item_type = create(:item_type, name: 'Smartphone')
    create(:item, registry_number: '12345678910', status: :stolen,
                  item_type: item_type)

    visit root_path

    select 'Smartphone', from: 'Tipo'
    fill_in 'Número de registro', with: '12345678910'
    click_on 'Buscar'

    fill_in 'Paradeiro do item:', with: ''
    click_on 'Enviar para o proprietário'

    expect(page).to have_content('Mensagem não pode ficar em branco')
  end
end
