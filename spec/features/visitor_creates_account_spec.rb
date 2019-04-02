require 'rails_helper'

feature 'Visitor creates user account' do
  scenario 'successfully' do
    visit root_path

    click_on 'Novo usuário'
    fill_in 'E-mail', with: 'pedro@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo, pedro@email.com.')
  end

  scenario 'and must fill all fields' do
    visit root_path

    click_on 'Novo usuário'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    click_on 'Cadastrar'

    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
  end
end
