require 'rails_helper'

feature 'User delete item' do
  scenario 'successfuly' do
    user = create(:user, name: 'Vini', email: 'vini@email.com')
    create(:item, title: 'Meu pc', user: user)
    create(:item, title: 'Meu celular', user: user)
    login_as user, scope: :user

    visit root_path
    click_on 'Meus itens'
    click_on 'Meu pc'
    click_on 'Excluir item'

    expect(current_path).to eq my_items_path
    expect(page).to have_content('Item excluido com sucesso')
    expect(page).not_to have_content('Meu pc')
    expect(page).to have_content('Meu celular')
    expect(Item.count).to eq 1
  end
end
