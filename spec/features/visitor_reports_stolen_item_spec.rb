require 'rails_helper'

feature 'Visitor reports stolen item' do
  scenario 'successfully' do
    pending
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
    expect(page).to have_content('Enviamos sua mensagem para o dono do Smartphone NS 12345678910') 
  end
end