# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

people = [
  ['Johnny Cash', '555555555', Date.new(1932, 2, 26)],        # id = 1
  ['Sid Vicious', '555555555', Date.new(1957, 5, 10)],        # id = 2
  ['Axl Rose', '555555555', Date.new(1962, 2, 6)],            # id = 3
  ['Joey Ramone', '555555555', Date.new(1951, 5, 19)],        # id = 4
  ['Bruce Dickinson', '555555555', Date.new(1958, 8, 7)],     # id = 5
  ['Kurt Cobain', '555555555', Date.new(1967, 2, 20)],        # id = 6
  ['Elvis Presley', '555555555', Date.new(2008, 8, 17)]       # id = 7
]

people.each do |name, paper_number, birth_date|
  Person.create!(
    name: name, paper_number: paper_number, birth_date: birth_date
  )
end

animal_types = [
  'Cavalo',       # id = 1
  'Cachorro',     # id = 2
  'Papagaio',     # id = 3
  'Lhama',        # id = 4
  'Iguana',       # id = 5
  'Ornitorrinco'  # id = 6
]

animal_types.each do |animal_type|
  AnimalType.create!(name: animal_type)
end

animals = [
  ['Pé de Pano', 199.99, 1, 1],
  ['Rex', 99.99, 2, 2],
  ['Ajudante do Papai Noel', 99.99, 2, 3],
  ['Rex', 103.99, 3, 4],
  ['Flora', 103.99, 4, 5],
  ['Dino', 177.99, 5, 6],
  ['Lassie', 407.99, 6, 7]
]


animals.each do |name, monthly_cost, animal_type_id, person_id|
  Animal.create!(
    name: name,
    monthly_cost: monthly_cost,
    animal_type_id: animal_type_id,
    person_id: person_id
  )
end
