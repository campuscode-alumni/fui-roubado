require 'rails_helper'

feature 'User logs in' do
  scenario 'successfully' do
    create(:user, name: 'Pedro', email: 'pedro@email.com', password: '123456')

    visit root_path
    click_on 'Entrar'
    fill_in 'E-mail', with: 'pedro@email.com'
    fill_in 'Senha', with: '123456'
    click_on 'Enviar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo, Pedro.')
    expect(page).not_to have_content('Entrar')
    expect(page).to have_content('Sair')
  end

  scenario 'and logs out' do
    user = create(:user, email: 'pedro@email.com', password: '123456')
    login_as user, scope: :user

    visit root_path
    click_on 'Sair'

    expect(current_path).to eq root_path
    expect(page).to have_content('Entrar')
    expect(page).not_to have_content('Sair')
  end

  scenario 'and must fill valid E-mail and password' do
    visit root_path

    click_on 'Entrar'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    click_on 'Enviar'

    expect(page).to have_content('E-mail ou senha inválida')
  end
end
