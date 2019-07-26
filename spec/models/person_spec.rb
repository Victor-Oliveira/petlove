# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
#  id           :bigint           not null, primary key
#  name         :string
#  paper_number :string
#  birth_date   :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

require 'rails_helper'

RSpec.describe Person, type: :model do
  it { is_expected.to have_many(:animals) }

  # Validations
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:paper_number) }
  it { is_expected.to validate_presence_of(:birth_date) }

  describe '#initial_letter' do
    let(:person) { create(:person) }

    it 'returns a person\'s initial letter' do
      expect(person.initial_letter).to eq('P')
    end
  end

  describe '#total_monthly_cost' do
    let(:person) { create(:person, :with_animals) }

    it 'returns a sum of the total monthly cost for a person\'s animals' do
      expect(person.total_monthly_cost.to_f).to eq(30)
    end
  end

  describe '#over_monthly_cost?' do
    let(:person) { create(:person, :with_animals) }

    context 'when a person\'s total animals monthly cost is bellow permitted' do
      it 'returns true' do
        expect(person.over_monthly_cost?).to eq(false)
      end
    end

    context 'when a person\'s total animals monthly cost is above permitted' do
      it 'returns false' do
        animal_type = create(:animal_type)

        Animal.create(
          name: 'Outro animal',
          monthly_cost: 1000,
          animal_type: animal_type,
          person: person
        )

        expect(person.reload.over_monthly_cost?).to eq(true)
      end
    end
  end

  describe '#age' do
    let(:person) { create(:person) }

    it 'returns a person\'s age' do
      expect(person.age).to eq(25)
    end
  end

  describe '#not_allowed_by_initial?' do
    let(:person) { create(:person) }

    context 'when the person is allowed to have an animal type' do
      it 'returns false' do
        allow(ENV).to receive(:[]).with('NOT_ALLOWED_INITIALS')
          .and_return('')

        allow(ENV).to receive(:[]).with('ANIMAL_TYPES_NOT_ALLOWED_BY_INITIAL')
          .and_return('')

        expect(person.not_allowed_by_initial?('Cachorro')).to eq(false)
      end
    end

    context 'when the person is not allowed to have an animal type' do
      it 'returns true' do
        allow(ENV).to receive(:[]).with('NOT_ALLOWED_INITIALS')
          .and_return(person.initial_letter)

        allow(ENV).to receive(:[]).with('ANIMAL_TYPES_NOT_ALLOWED_BY_INITIAL')
          .and_return('Cachorro')

        expect(person.not_allowed_by_initial?('Cachorro')).to eq(true)
      end
    end
  end

  describe '#not_allowed_by_age?' do
    let(:person) { create(:person) }

    context 'when the person is allowed to have an animal type' do
      it 'returns false' do
        allow(ENV).to receive(:[]).with('MINIMUM_AGE')
          .and_return('')

        allow(ENV).to receive(:[])
          .with('ANIMAL_TYPES_NOT_ALLOWED_BELLOW_MINIMUM_AGE')
          .and_return('')

        expect(person.not_allowed_by_age?('Iguana')).to eq(false)
      end
    end

    context 'when the person is not allowed to have an animal type' do
      it 'returns true' do
        allow(ENV).to receive(:[]).with('MINIMUM_AGE')
          .and_return('50')

        allow(ENV).to receive(:[])
          .with('ANIMAL_TYPES_NOT_ALLOWED_BELLOW_MINIMUM_AGE')
          .and_return('Iguana')

        expect(person.not_allowed_by_age?('Iguana')).to eq(true)
      end
    end
  end
end
