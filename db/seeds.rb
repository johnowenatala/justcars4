# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
bmw = Brand.where(name: 'BMW').first_or_create
mazda = Brand.where(name: 'Mazda').first_or_create
citroen = Brand.where(name: 'Citroën').first_or_create
audi = Brand.where(name: 'Audi').first_or_create

bmw_models = [
  Model.where(brand: bmw, name: '316i').first_or_create,
  Model.where(brand: bmw, name: '320i').first_or_create,
  Model.where(brand: bmw, name: 'Z4 sDrive35i').first_or_create
]

bmw_models[2].cars.where(
  year: 2011,
  price: 51_046,
  image_file_name: '2013-BMW-Z4-sDrive35is.jpg',
  color: 'Negro',
  fuel: 'Diesel',
  currency: 2,
  description: Faker::Hipster.paragraph(5),
  quantity: 6
).first_or_create
bmw_models[1].cars.where(
  year: 2016,
  price: 23_400_000,
  image_file_name: 'bmw-320i-sedan-1_1600x0w.jpg',
  color: 'Blanco',
  fuel: 'Bencina',
  description: Faker::Hipster.paragraph(5),
  quantity: 4
).first_or_create
bmw_models[1].cars.where(
  year: 2017,
  price: 1_016,
  image_file_name: 'zbmw3-series_01.jpg',
  color: 'Rojo',
  fuel: 'Bencina',
  currency: 1,
  description: Faker::Hipster.paragraph(5),
  quantity: 13
).first_or_create


mazda_models = [
  Model.where(brand: mazda, name: '3 sedan').first_or_create,
  Model.where(brand: mazda, name: 'CX-5').first_or_create,
  Model.where(brand: mazda, name: '2 sedan').first_or_create,
]

mazda_models[0].cars.where(
  year: 2017,
  price: 14_990_000,
  image_file_name: '76277_2016_mazda_Mazda3.jpg',
  quantity: 1
).first_or_create
mazda_models[0].cars.where(
  year: 2016,
  price: 12_290_000,
  image_file_name: '2016-m3s-soulred-onroad-mde-m3s-gallery.jpg',
  description: Faker::Hipster.paragraph(5),
  quantity: 6
).first_or_create
mazda_models[1].cars.where(
  year: 2016,
  price: 21_390_000,
  image_file_name: '2016-mazda-cx-5-grand-touring-front-quarter-left_720.jpg',
  quantity: 4
).first_or_create
mazda_models[1].cars.where(
  year: 2017,
  price: 23_590_000,
  image_file_name: '2016_mazda_cx-5-pic-4296697883253383084-1600x1200.jpeg',
  color: 'Rojo',
  fuel: 'Diesel',
  quantity: 4
).first_or_create
mazda_models[2].cars.where(
  year: 2016,
  price: 9_690_000,
  image_file_name: 'landscape-1427470540-scion-ia-08.jpg',
  quantity: 0
).first_or_create

audi_models = [
  Model.where(brand: audi, name: 'A4').first_or_create,
  Model.where(brand: audi, name: 'A6').first_or_create,
  Model.where(brand: audi, name: 'S8').first_or_create,
  Model.where(brand: audi, name: 'Q3').first_or_create,
  Model.where(brand: audi, name: 'TT').first_or_create,
]

audi_models[1].cars.where(
  year: 2016,
  price: 30_490_000,
  image_file_name: '2016-Audi-A6-European-Spec-side-profile-02.jpg',
  color: 'Azul',
  fuel: 'Bencina',
  description: 'La minuciosidad de un automóvil consiste en la interacción de todos sus puntos fuertes. Y sus numerosas posibilidades, que cada día se descubren como si fueran algo nuevo. El Audi A6 reúne, en una simbiosis elegante y al mismo tiempo deportiva, innovadoras tecnologías con una conducción que sorprende por su agilidad. El Audi A6 le fascinará desde el primer momento. Despierta emociones. Un diseño que destila progreso y deportividad.',
  quantity: 6
).first_or_create

audi_models[2].cars.where(
  year: 2016,
  price: 174_500,
  currency: 2,
  image_file_name: 'audi-s8-5_1600x0w.jpg',
  color: 'Negro',
  fuel: 'Diesel',
  description: 'Gran carisma, pura potencia y la tecnología del más alto nivel. Todo combinado en uno de los sedanes más deportivos que se conocen. Audi S8. Dinámico. Superior. Dispone de forma opcional de los novedosos Focos Audi Matrix LED. Apasionantemente deportivo.',
  quantity: 3
).first_or_create

audi_models[3].cars.where(
  year: 2016,
  price: 29_990_000,
  image_file_name: 'Audi-Q3-2015-mango-yellow-545.jpg',
  color: 'Amarillo',
  fuel: 'Bencina',
  description: 'Sentir nostalgia por algo que aún no has vivido. Buscar constantemente lo desconocido. O moverte siempre por el incontrolable deseo de exprimir el mundo.
Saciar un espíritu con pasión por viajar resulta sencillo si se tiene (y se siente) la libertad necesaria para poderlo hacer. El Audi Q3 gracias a su naturaleza tanto deportiva y eficiente como versátil y moderna, se presenta dispuesto y preparado para saciar la versión más curiosa de ti mismo llegando, siempre, allí donde tu instinto te lleve.',
  quantity: 0
).first_or_create

audi_models[4].cars.where(
  year: 2016,
  price: 40_990,
  currency: 2,
  image_file_name: 'Audi-TT-S-Line-2016.jpg',
  color: 'Rojo',
  fuel: 'Diesel',
  description: 'El primer Audi TT vio la luz en 1998 y supuso el nacimiento de todo un icono: un vehículo que sentó nuevas bases en cuanto a diseño, motor y carrocería. Un vehículo que marcó un antes y un después en el mundo de la automoción. Y que enamoró al público. Vuelve un vehículo que revolucionó el diseño y la deportividad. Reinterpretar completamente una figura icónica y que siga siendo, en esencia, la misma. Rendir un justo homenaje a las míticas formas que elevaron a la categoría de clásico a la primera generación del Audi TT.',
  quantity: 0
).first_or_create

puts "Cargados #{Brand.count} marcas, #{Model.count} modelos, #{Car.count} autos"