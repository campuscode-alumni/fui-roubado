require 'rails_helper'

feature 'User adds item' do
  scenario 'successfully' do
    user = create(:user, name: 'Vini')
    item_type = create(:item_type, name: 'Notebook')
    create(:brand, name: 'Apple', item_type: item_type)
    login_as user, scope: :user

    visit root_path
    click_on 'Meus itens'
    click_on 'Cadastrar item'
    select 'Notebook', from: 'Tipo'
    select 'Apple', from: 'Marca'
    fill_in 'Título', with: 'MacbookPro 2011'
    fill_in 'Número de registro', with: '25692765278'
    fill_in 'Modelo', with: 'Pro-2011'
    fill_in 'Cor', with: 'Branco'
    fill_in 'Descrição', with: 'Tem um adesivo de ursinho na tampa.'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'notebook.jpg')
    click_on 'Enviar'

    expect(current_path).to eq item_path(1)
    expect(page).to have_css('h3', text: 'MacbookPro 2011')
    expect(page).to have_css('h5', text: 'Notebook')
    expect(page).to have_css('h6', text: 'Número de registro: 25692765278')
    expect(page).to have_css('p', text: 'Apple')
    expect(page).to have_css('p', text: 'Pro-2011')
    expect(page).to have_css('p', text: 'Branco')
    expect(page).to have_css('p', text: 'Tem um adesivo de ursinho na tampa.')
    expect(page).to have_css('img[src*="notebook.jpg"]')
  end

  scenario 'and title, type, brand, registry number cant be blank' do
    user = create(:user, name: 'Vini')
    item_type = create(:item_type, name: 'Notebook')
    create(:brand, name: 'Apple', item_type: item_type)
    login_as user, scope: :user

    visit root_path
    click_on 'Meus itens'
    click_on 'Cadastrar item'
    fill_in 'Título', with: ''
    fill_in 'Número de registro', with: ''
    fill_in 'Modelo', with: ''
    fill_in 'Cor', with: 'Branco'
    fill_in 'Descrição', with: 'Tem um adesivo de ursinho na tampa.'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'notebook.jpg')
    click_on 'Enviar'

    expect(page).to have_content('não pode ficar em branco')
  end

  scenario 'and register unique value' do
    user = create(:user, name: 'Vini')
    item_type = create(:item_type, name: 'Notebook')
    create(:brand, name: 'Apple', item_type: item_type)
    create(:item, registry_number: '25692765278', user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Meus itens'
    click_on 'Cadastrar item'
    select 'Notebook', from: 'Tipo'
    select 'Apple', from: 'Marca'
    fill_in 'Título', with: 'MacbookPro 2011'
    fill_in 'Número de registro', with: '25692765278'
    fill_in 'Modelo', with: 'Pro-2011'
    fill_in 'Cor', with: 'Branco'
    fill_in 'Descrição', with: 'Tem um adesivo de ursinho na tampa.'
    attach_file 'Foto', Rails.root.join('spec', 'support', 'notebook.jpg')
    click_on 'Enviar'

    expect(page).to have_content('Número de registro já está em uso')
  end

  scenario 'and must be logged in' do
    visit new_item_path

    expect(current_path).to eq new_user_session_path
  end
end
