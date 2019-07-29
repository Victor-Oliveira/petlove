# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Animals', type: :request do
  let(:person) { create(:person) }

  describe 'GET /people/:person_id/animals' do
    it 'works! (now write some real specs)' do
      get person_animals_path(person)

      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /people/:person_id/animals/:id' do
    let(:animal) { create(:animal) }

    it 'returns a success response' do
      get person_animal_path(person, animal)

      expect(response).to have_http_status(200)
    end

    it 'returns the animal\'s info' do
      get person_animal_path(person, animal)

      expect(response.body).to include(animal.name)
      expect(response.body).to include(animal.monthly_cost.to_s)
      expect(response.body).to include(animal.person.name)
      expect(response.body).to include(animal.animal_type.name)
    end
  end

  describe 'POST /people/:person_id/animals/' do
    let(:animal_type) { create(:animal_type) }

    it 'creates a new animal' do
      get new_person_animal_path(person)

      expect(response).to render_template(:new)

      post person_animals_path,
           params: {
             animal: {
               name: 'Animal',
               monthly_cost: 100.00,
               person_id: person.id,
               animal_type_id: animal_type.id
             }
           }

      expect(response)
        .to redirect_to("/people/#{person.id}/animals/#{Animal.last.id}")
    end

    it 'redirects to the Animals\'s show page and flashes creation message' do
      get new_person_animal_path(person)

      expect(response).to render_template(:new)

      post person_animals_path,
           params: {
             animal: {
               name: 'Animal',
               monthly_cost: 100.00,
               person_id: person.id,
               animal_type_id: animal_type.id
             }
           }

      expect(response)
        .to redirect_to("/people/#{person.id}/animals/#{Animal.last.id}")

      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include(
        I18n.t(:create, model: I18n.t('activerecord.models.animal.one'))
      )
    end
  end

  describe 'POST /people/:person_id/animals/:id' do
    let(:animal) { create(:animal) }
    let(:animal_type) { create(:animal_type) }

    it 'updates an animal' do
      get edit_person_animal_path(person.id, animal.id)

      expect(:response).to render_template(:edit)

      put person_animal_path(person.id, animal.id),
          params: {
            animal: {
              name: 'Outro animal',
              monthly_cost: 150.00,
              person_id: person.id,
              animal_type_id: animal_type.id
            }
          }

      expect(response)
        .to redirect_to("/people/#{person.id}/animals/#{Animal.last.id}")
    end

    it 'redirects to the Animal\'s show page and flashes update message' do
      get edit_person_animal_path(person.id, animal.id)

      expect(:response).to render_template(:edit)

      put person_animal_path(person.id, animal.id),
          params: {
            animal: {
              name: 'Outro animal',
              monthly_cost: 150.00,
              person_id: person.id,
              animal_type_id: animal_type.id
            }
          }

      expect(response)
        .to redirect_to("/people/#{person.id}/animals/#{Animal.last.id}")

      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include(
        I18n.t(:update, model: I18n.t('activerecord.models.animal.one'))
      )
    end
  end

  describe 'DELETE /people/:person_id/animals/:id' do
    let(:animal) { create(:animal) }

    it 'deletes an animal' do
      delete person_animal_path(person, animal)

      expect(response).to redirect_to("/people/#{person.id}/animals")

      expect { Animal.find(animal.id) }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'redirects to the Animal\'s index page and flashes deletion msg' do
      delete person_animal_path(person, animal)

      expect(response).to redirect_to("/people/#{person.id}/animals")

      follow_redirect!

      expect(Animal.count).to eq(0)
      expect(response).to render_template(:index)
      expect(response.body).to include(
        I18n.t(:delete, model: I18n.t('activerecord.models.animal.one'))
      )
    end
  end
end
