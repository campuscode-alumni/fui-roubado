require 'rails_helper'

feature 'User delete item' do
  scenario 'successfuly' do
    user = create(:user, name: 'Vini', email: 'vini@email.com')
    item_type = create(:item_type, name: 'Notebook')
    create(:brand, name: 'Apple', item_type: item_type)
    create(:item, registry_number: 'AP4521', user: user)
    login_as user, scope: :user

    visit item_path
    click_on 'Meus itens'
    click_on 'Excluir item'
    click_on 'Excluir'

    expect(current_path).to eq item_path(1)
    expect(page).to have_content('Item excluido com sucesso')
    expect(Item.count).to eq 0
  end
end