require 'rails_helper'

feature 'User views his registered items' do
  scenario 'successfully' do
    user1 = create(:user)
    item1 = create(:item, title: 'Notebook Macbook Pro', user: user1)
    item1.photo.attach(io: File.open(Rails.root
      .join('spec', 'support', 'notebook.jpg')), filename: 'notebook.jpg')
    create(:item, title: 'Smartphone Samsung', user: user1)
    create(:item, title: 'Camera fotográfica Sony', user: user1)

    login_as user1, scope: :user

    visit root_path
    click_on 'Meus itens'

    expect(current_path).to eq my_items_path
    expect(page).to have_css('li', text: 'Notebook Macbook Pro')
    expect(page).to have_css('img[src*="notebook.jpg"]')
    expect(page).to have_css('li', text: 'Smartphone Samsung')
    expect(page).to have_css('li', text: 'Camera fotográfica Sony')
  end

  scenario 'and sees only his items' do
    user1 = create(:user)
    user2 = create(:user)
    item1 = create(:item, title: 'Notebook Macbook Pro', user: user1)
    item1.photo.attach(io: File.open(Rails.root
      .join('spec', 'support', 'notebook.jpg')), filename: 'notebook.jpg')
    create(:item, title: 'Smartphone Samsung', user: user1)
    create(:item, title: 'Camera fotográfica Sony', user: user1)
    create(:item, title: 'Notebook Dell', user: user2)
    create(:item, title: 'Smartphone Motorola', user: user2)

    login_as user1, scope: :user

    visit root_path
    click_on 'Meus itens'

    expect(current_path).to eq my_items_path
    expect(page).to have_css('li', text: 'Notebook Macbook Pro')
    expect(page).to have_css('img[src*="notebook.jpg"]')
    expect(page).to have_css('li', text: 'Smartphone Samsung')
    expect(page).to have_css('li', text: 'Camera fotográfica Sony')
    expect(page).not_to have_css('li', text: 'Notebook Dell')
    expect(page).not_to have_css('li', text: 'Smartphone Motorola')
  end

  scenario 'and has no registered items' do
    user1 = create(:user)
    user2 = create(:user)
    create(:item, title: 'Notebook Dell', user: user2)
    create(:item, title: 'Smartphone Motorola', user: user2)

    login_as user1, scope: :user

    visit root_path
    click_on 'Meus itens'

    expect(current_path).to eq my_items_path
    expect(page).to have_content('Não há itens cadastrados')
    expect(page).not_to have_css('li', text: 'Notebook Dell')
    expect(page).not_to have_css('li', text: 'Smartphone Motorola')
  end

  scenario 'and views item details' do
    user = create(:user)
    item_type = create(:item_type, name: 'Notebook')
    brand = create(:brand, name: 'Apple', item_type: item_type)
    create(:item, title: 'Notebook Dell', user: user,
                  description: 'Tem um adesivo de ursinho na tampa.',
                  registry_number: 'ouhfoe121414', item_type: item_type,
                  model: 'XP-2011', color: 'Branco', brand: brand)
    login_as user, scope: :user
    visit my_items_path

    click_on 'Notebook Dell'

    expect(current_path).to eq item_path(1)
    expect(page).to have_css('h1', text: 'Notebook Dell')
    expect(page).to have_css('p', text: 'Notebook')
    expect(page).to have_css('p', text: 'Número de registro: ouhfoe121414')
    expect(page).to have_css('p', text: 'Apple')
    expect(page).to have_css('p', text: 'XP-2011')
    expect(page).to have_css('p', text: 'Branco')
    expect(page).to have_css('p', text: 'Tem um adesivo de ursinho na tampa.')
  end
end
