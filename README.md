# PetLove

A small and simple take on a animal management project proposal, taking business 
rules aforementioned to create its funcionalities.

## Dependencies
```
Ruby >= 2.6.3
Rails >= 5.2.3
Docker/Docker compose >= 18
```

## Setup
Clone this repository by running and go to its folder:
```shell
git clone git@github.com:Victor-Oliveira/petlove.git
cd petlove
```

**The following commands may need to be used as super-user**

Build the docker image using:
```shell
docker-compose build
```

Use the following command to create and run migrations, aswell as add seed data
```shell
docker-compose run web rake db:create db:migrate db:seed
```

Run the application using:
```shell
docker-compose up
```

## Running tests
Use the following command to run rspec tests
```shell
docker-compose run web bundle exec rspec
```

Use the following command to run rubocop
```shell
docker-compose run web rubocop
```

## The following code for each question is a snippet for each answer about ActiveRecord queries
### Questões:
- Qual é o custo médio dos animais do tipo cachorro?
```shell
Animal.where(animal_type: AnimalType.find_by(name: 'Cachorro'))
  .average(:monthly_cost).to_s
```

- Quantos cachorros existem no sistema?
```shell
Animal.where(animal_type: AnimalType.find_by(name: 'Cachorro')).size
```

- Qual o nome dos donos dos cachorros (Array de nomes)
```shell
Person.includes(:animals)
  .where(animals: { animal_type: AnimalType.find_by(name: 'Cachorro') })
  .pluck(:name)
```

- Retorne as pessoas ordenando pelo custo que elas tem com os animais (Maior para menor)
```shell
Person.includes(:animals)
  .group(:name)
  .average(:monthly_cost)
  .sort_by { |name, monthly_cost| monthly_cost }
  .reverse.map { |name, monthy_cost| name }
```

- Levando em consideração o custo mensal, qual será o custo de 3 meses de cada pessoa?
```shell
Person.includes(:animals)
  .group(:name)
  .average(:monthly_cost)
  .sort_by{ |name, monthly_cost| monthly_cost }
  .reverse
  .map { |name, monthly_cost| [name, (monthly_cost * 3).to_s] }
```
