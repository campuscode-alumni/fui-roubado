require 'rails_helper'

feature 'Admin logs in' do
  scenario 'successfully' do
    create(:admin, email: 'admin@email.com', password: '123456')
    visit root_path
    visit new_admin_session_path
    fill_in 'E-mail', with: 'admin@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo, admin@email.com.')
  end

  scenario 'and must fill valid information' do
    create(:admin, email: 'admin@email.com', password: '123456')
    visit root_path

    visit new_admin_session_path
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    click_on 'Enviar'

    expect(page).to have_content('E-mail ou senha inválida')
  end
end
