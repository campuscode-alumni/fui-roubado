require 'rails_helper'

feature 'Visitor creates user account' do
  scenario 'successfully' do
    create(:city, name: 'Rio de Janeiro')
    visit root_path

    click_on 'Novo usuário' 
    fill_in 'Nome', with: 'Pedro'
    fill_in 'Apelido', with: 'pedroca22'
    fill_in 'CPF', with: '038.173.270-30'
    select 'Rio de Janeiro', from: 'Cidade'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'foto.jpg')
    fill_in 'E-mail', with: 'pedro@email.com'
    fill_in 'Senha', with: '123456'
    fill_in 'Confirmar senha', with: '123456'
    click_on 'Cadastrar'

    expect(current_path).to eq root_path
    expect(page).to have_content('Bem vindo, Pedro.')
  end

  scenario 'and must fill all fields' do
    create(:city, name: 'Rio de Janeiro')
    visit root_path

    click_on 'Novo usuário' 
    fill_in 'Nome', with: ''
    fill_in 'Apelido', with: ''
    fill_in 'CPF', with: ''
    select 'Rio de Janeiro', from: 'Cidade'
    fill_in 'E-mail', with: ''
    fill_in 'Senha', with: ''
    fill_in 'Confirmar senha', with: ''
    click_on 'Cadastrar'
    

    expect(page).to have_content('Senha não pode ficar em branco')
    expect(page).to have_content('E-mail não pode ficar em branco')
  end
end
