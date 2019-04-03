Admin.create!(email:'admin@email.com', password: '123456')
city = City.create!(name: 'Campinas')
user = User.create!(email: 'vini@email.com', password: '123456',
                   name: 'Vini', nickname: 'Vini22', city: city, cpf: '096.509.350-61')
ItemType.create!(name: 'Notebook')
item_type1 = ItemType.create!(name: 'Equipamento fotográfico')
item_type2 = ItemType.create!(name: 'Aparelho celular')
Brand.create(name: 'Apple', item_type: item_type1)
Brand.create(name: 'Samsung',item_type: item_type2)