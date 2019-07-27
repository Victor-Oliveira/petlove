# frozen_string_literal: true

# == Schema Information
#
# Table name: animals
#
#  id             :bigint           not null, primary key
#  name           :string
#  monthly_cost   :decimal(10, 2)
#  person_id      :bigint
#  animal_type_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Animal, type: :model do
  # Associations
  it { is_expected.to belong_to(:person) }
  it { is_expected.to belong_to(:animal_type) }

  # Validations
  context 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:monthly_cost) }

    let(:person) { create(:person) }
    let(:animal_type) { create(:animal_type) }

    it 'validates person\'s animal total monthly cost' do
      create(:animal, monthly_cost: 1001.00, person: person)

      person.reload

      another_animal = Animal.create(
        name: 'Outro animal',
        monthly_cost: 1,
        animal_type: animal_type,
        person: person
      )

      expect(another_animal.errors.full_messages).to eq(
        ['Pessoa está com o custo mensal de animais acima do valor permitido']
      )
    end

    it 'validates a person\'s initial letter and animal type' do
      allow(ENV).to receive(:[]).with('MAX_TOTAL_ANIMAL_COST')
        .and_return('1000')

      allow(ENV).to receive(:[]).with('NOT_ALLOWED_INITIALS')
        .and_return(person.initial_letter)

      allow(ENV).to receive(:[]).with('ANIMAL_TYPES_NOT_ALLOWED_BY_INITIAL')
        .and_return(animal_type.name)

      allow(ENV).to receive(:[]).with('MINIMUM_AGE')
        .and_return('18')

      allow(ENV).to receive(:[])
        .with('ANIMAL_TYPES_NOT_ALLOWED_BELLOW_MINIMUM_AGE')
        .and_return('')

      animal = Animal.create(
        name: 'Outro animal',
        monthly_cost: 1,
        animal_type: animal_type,
        person: person
      )

      expect(animal.errors.full_messages).to eq(
        [
          'Pessoa não pode ter animais do tipo Cachorro, pois o nome ' \
          'inicia com a letra P'
        ]
      )
    end

    it 'validates a person\'s age and animal type' do
      allow(ENV).to receive(:[]).with('MAX_TOTAL_ANIMAL_COST')
        .and_return('1000')

      allow(ENV).to receive(:[]).with('NOT_ALLOWED_INITIALS')
        .and_return('')

      allow(ENV).to receive(:[]).with('ANIMAL_TYPES_NOT_ALLOWED_BY_INITIAL')
        .and_return('')

      allow(ENV).to receive(:[]).with('MINIMUM_AGE')
        .and_return('50')

      allow(ENV).to receive(:[])
        .with('ANIMAL_TYPES_NOT_ALLOWED_BELLOW_MINIMUM_AGE')
        .and_return(animal_type.name)

      animal = Animal.create(
        name: 'Outro animal',
        monthly_cost: 1,
        animal_type: animal_type,
        person: person
      )

      expect(animal.errors.full_messages).to eq(
        [
          'É necessario ter acima de 50 anos para poder ter animais ' \
          'do tipo Cachorro'
        ]
      )
    end
  end
end
