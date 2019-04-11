Admin.create!(email:'admin@email.com', password: '123456')
city1 = City.create!(name: 'São Paulo')
City.create!(name: 'Rio de Janeiro')
user = User.create!(email: 'vini@email.com', password: '123456',
                   name: 'Vini', nickname: 'Vini22', city: city1, cpf: '096.509.350-61')
ItemType.create!(name: 'Notebook')
item_type1 = ItemType.create!(name: 'Equipamento fotográfico')
item_type2 = ItemType.create!(name: 'Aparelho celular')
brand1 = Brand.create!(name: 'Apple', item_type: item_type1)
brand2 = Brand.create!(name: 'Samsung',item_type: item_type2)
item1 = Item.create!(title: 'Celular da mãe', item_type: item_type2,
            status: :stolen, user: user, registry_number: '234567',
            brand: brand1, model: 'DD-00410', color: 'Branco',
            description: 'Tem um rachadura na tela.')
item2 = Item.create!(title: 'Celular da vó', item_type: item_type2,
            status: :stolen, user: user, registry_number: '123456',
            brand: brand2, model: 'XT-00010', color: 'Azul',
            description: 'Tem um adesivo de coração na tampa.')
item3 = Item.create!(title: 'Camera antiga', item_type: item_type1,
            status: :owned, user: user, registry_number: '891011',
            brand: brand2, model: 'Canon t3i', color: 'Preto',
            description: 'Tem um adesivo de coração na tampa.')
report1 = Report.create!(user: user, description: 'Assalto no ponto de ônibus',
               ocurrance_date: '2017-04-03 22:40:50',
               address: 'Praça da Sé, São Paulo, SP', items:[item1])
Report.create!(user: user, description: 'Ladrão',
               ocurrance_date: '2015-02-03 18:00:50',
               address: 'Alameda Santos, 1293, São Paulo, SP', items:[item2])
item1.photo.attach(io: File.open(Rails.root.join('public', 'nokia1.jpg')), filename: 'nokia1.jpg')
item2.photo.attach(io: File.open(Rails.root.join('public', 'nokia2.jpg')), filename: 'nokia2.jpg')
item3.photo.attach(io: File.open(Rails.root.join('public', 't3i.jpg')), filename: 't3i.jpg')
report1.police_report.attach(io: File.open(Rails.root.join('public', 'boletim_de_ocorrencia.jpg')), filename: 'boletim_de_ocorrencia.jpg')