require 'rails_helper'

feature 'visitor search item' do
  scenario 'successfully' do
    pending
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, registry_number: '12345678910', status: :stolen, item_type:item_type)
    create(:item, registry_number: 'abcd', status: :owned, item_type:item_type)
    create(:item, registry_number: 'zxcv', status: :owned, item_type:item_type2)

    visit root_path

    select 'Notebook', from: 'Tipo'
    fill_in '12345678910', with: 'Número de registro'
    click_on 'Buscar'

    expect(current_path).to eq(items_path)
    expect(page).not_to have_content('abcd')
    expect(page).to have_css('p', text: 'O Notebook com número de registro 12345678910 foi reportado como roubado' )
  end
end