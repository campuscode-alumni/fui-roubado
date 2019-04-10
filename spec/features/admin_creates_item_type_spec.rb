require 'rails_helper'

feature 'Admin registers item type' do
  scenario 'successfully' do
    admin = create(:admin)
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
    admin = create(:admin)
    login_as admin, scope: :admin

    visit root_path
    click_on 'Tipos de itens'
    click_on 'Criar tipo de item'
    fill_in 'Nome', with: ''
    click_on 'Salvar'

    expect(page).to have_content('Não foi possível salvar o tipo de item')
  end

  scenario 'and must be logged in' do
    visit root_path

    expect(page).not_to have_content('Tipos de itens')
  end

  scenario 'and must be admin' do
    user = create(:user)
    login_as user, scope: :user

    visit root_path

    expect(page).not_to have_content('Tipos de itens')
  end
end
