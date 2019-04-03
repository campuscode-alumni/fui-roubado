require 'rails_helper'

feature 'visitor search item' do
  scenario 'successfully' do
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, registry_number: '12345678910', status: :stolen,
                  item_type: item_type)
    create(:item, registry_number: 'abcd', status: :owned,
                  item_type: item_type)
    create(:item, registry_number: 'zxcv', status: :owned,
                  item_type: item_type2)

    visit root_path

    select 'Notebook', from: 'Tipo'
    fill_in 'Número de registro', with: '12345678910'
    click_on 'Buscar'

    expect(current_path).to eq(search_path)
    expect(page).not_to have_content('abcd')
    expect(page).not_to have_content('O item procurado não está registrado'\
                                     ' como roubado ou furtado.')
    expect(page).to have_css('p', text: 'O Notebook com número de registro'\
                                        ' 12345678910 foi reportado como'\
                                        ' roubado')
  end

  scenario 'and finds no matches' do
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, registry_number: '12345678910', status: :stolen,
                  item_type: item_type)
    create(:item, registry_number: 'abcd', status: :owned,
                  item_type: item_type)
    create(:item, registry_number: 'zxcv', status: :owned,
                  item_type: item_type2)

    visit root_path

    select 'Notebook', from: 'Tipo'
    fill_in 'Número de registro', with: 'bananapath'
    click_on 'Buscar'

    expect(current_path).to eq(search_path)
    expect(page).not_to have_content('abcd')
    expect(page).not_to have_content('12345678910')
    expect(page).not_to have_content('zxcv')
    expect(page).to have_content('O item procurado não está registrado como'\
                                 ' roubado ou furtado.')
  end

  scenario 'and its registered as owned, not stolen' do
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, registry_number: '12345678910', status: :stolen,
                  item_type: item_type)
    create(:item, registry_number: 'abcd', status: :owned,
                  item_type: item_type)
    create(:item, registry_number: 'zxcv', status: :owned,
                  item_type: item_type2)

    visit root_path

    select 'Notebook', from: 'Tipo'
    fill_in 'Número de registro', with: 'abcd'
    click_on 'Buscar'

    expect(current_path).to eq(search_path)
    expect(page).not_to have_content('abcd')
    expect(page).not_to have_content('12345678910')
    expect(page).not_to have_content('zxcv')
    expect(page).to have_content('O item procurado não está registrado como'\
                                 ' roubado ou furtado.')
  end

  scenario 'and type and registry number dont match' do
    item_type = create(:item_type, name: 'Notebook')
    item_type2 = create(:item_type, name: 'Smartphone')
    create(:item, registry_number: '12345678910', status: :stolen,
                  item_type: item_type)
    create(:item, registry_number: 'abcd', status: :owned,
                  item_type: item_type)
    create(:item, registry_number: 'zxcv', status: :stolen,
                  item_type: item_type2)

    visit root_path

    select 'Notebook', from: 'Tipo'
    fill_in 'Número de registro', with: 'zxcv'
    click_on 'Buscar'

    expect(current_path).to eq(search_path)
    expect(page).not_to have_content('abcd')
    expect(page).not_to have_content('12345678910')
    expect(page).not_to have_content('zxcv')
    expect(page).to have_content('O item procurado não está registrado como'\
                                 ' roubado ou furtado.')
  end
end
