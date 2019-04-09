Admin.create!(email:'admin@email.com', password: '123456')
city1 = City.create!(name: 'Campinas')
City.create!(name: 'Rio de Janeiro')
user = User.create!(email: 'vini@email.com', password: '123456',
                   name: 'Vini', nickname: 'Vini22', city: city1, cpf: '096.509.350-61')
ItemType.create!(name: 'Notebook')
item_type1 = ItemType.create!(name: 'Equipamento fotográfico')
item_type2 = ItemType.create!(name: 'Aparelho celular')
brand1 = Brand.create(name: 'Apple', item_type: item_type1)
brand2 = Brand.create(name: 'Samsung',item_type: item_type2)
Item.create(title: 'Camera Aniversário da vó', item_type: item_type1,
            status: :owned, user: user, registry_number: '123456',
            brand: brand1, model: 'XT-00010', color: 'Branco',
            description: 'Tem um adesivo de coração na tampa.')
Item.create(title: 'Camera Aniversário da vó', item_type: item_type1,
            status: :owned, user: user, registry_number: '123456',
            brand: brand1, model: 'XT-00010', color: 'Branco',
            description: 'Tem um adesivo de coração na tampa.')