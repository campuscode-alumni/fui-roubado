require 'rails_helper'

feature 'Admin registers item type' do
  scenario 'successfully' do
    admin = create(:admin, email: 'admin@email.com', password: '123456')
    login_as admin, scope: :admin

    visit root_path
    click_on 'Tipos de itens'
    click_on 'Criar tipo de item'
    fill_in 'Nome', with: 'Notebook'
    click_on 'Salvar'

    expect(current_path).to eq item_types_path
    expect(page).to have_css('li', text: 'Notebook')
  end

  scenario 'and type must have a name' do
    admin = create(:admin, email: 'admin@email.com', password: '123456')
    login_as admin, scope: :admin

    visit root_path
    click_on 'Tipos de itens'
    click_on 'Criar tipo de item'
    fill_in 'Nome', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível salvar o tipo de item')
  end
end
