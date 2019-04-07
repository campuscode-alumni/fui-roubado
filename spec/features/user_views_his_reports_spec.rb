require 'rails_helper'

feature 'User views his reports' do
  scenario 'successfully' do
    user1 = create(:user)
    user2 = create(:user)
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    item1 = create(:item, title: 'Notebook Dell',
                          registry_number: '12345678910',
                          status: :owned, item_type: item_type, user: user1)
    item2 = create(:item, title: 'Smartphone Samsung', registry_number: 'abcd',
                          status: :owned, item_type: item_type2, user: user1)
    item3 = create(:item, title: 'Smartphone Motorola', registry_number: 'zxcv',
                          status: :owned, item_type: item_type2, user: user2)
    create(:report, ocurrance_date: '2019-02-02 20:05:50',
                    address: 'Rua do Zé', items: [item1], user: user1)
    create(:report, ocurrance_date: '2016-02-02 20:05:50',
                    address: 'Rua das Rosas', items: [item2], user: user1)
    create(:report, ocurrance_date: '2017-02-02 20:05:50',
                    address: 'Escadaria das bailarinas',
                    items: [item3], user: user2)

    login_as user1, scope: :user

    visit root_path
    click_on 'Meus relatórios'
    expect(current_path).to eq reports_path
    expect(page).to have_link('Rua do Zé')
    expect(page).to have_link('Rua das Rosas')
    expect(page).not_to have_link('Escadaria das bailarinas')
  end

  scenario 'and has no reports' do
    user1 = create(:user)
    user2 = create(:user)
    item_type = create(:item_type, name: 'Notebook')
    create(:item, title: 'Notebook Dell',
                  registry_number: '12345678910',
                  status: :owned, item_type: item_type, user: user2)
    login_as user1, scope: :user

    visit reports_path

    expect(page).not_to have_link('Notebook Dell')
    expect(page).to have_content('Não há relatórios cadastrados')
  end
end
