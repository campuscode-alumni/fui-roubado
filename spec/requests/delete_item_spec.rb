require 'rails_helper'

describe 'User deletes item' do
  it 'should be item owner' do
    user = create(:user, name: 'Vini', email: 'vini@email.com')
    user2 = create(:user, name: 'Paulo', email: 'paulo@email.com')
    item = create(:item, title: 'Meu pc', user: user2)
    login_as user, scope: :user

    delete "/items/#{item.id}"

    expect(response).to have_http_status(:forbidden)
    expect(Item.count).to eq 1
  end
end
