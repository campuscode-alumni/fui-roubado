require 'rails_helper'

feature 'Visitor views map' do
  scenario 'successfully' do
    pending
    visit root_path
    click_on 'Mapa de relatos'

    expect(current_path).to eq 'map_path'
  end
end
