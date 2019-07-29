# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalsController, type: :controller do
  let(:person) { create(:person) }
  let(:animal_type) { create(:animal_type) }

  let(:valid_attributes) do
    {
      name: 'Coragem',
      monthly_cost: BigDecimal(100),
      person_id: person.id,
      animal_type_id: animal_type.id
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Animal.create! valid_attributes

      get :index, params: { person_id: person.id }, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      animal = Animal.create! valid_attributes

      get :show, params: { id: animal.to_param, person_id: person.id },
                 session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: { person_id: person.id }, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      animal = Animal.create! valid_attributes

      get :edit, params: { id: animal.to_param, person_id: person.id },
                 session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Animal' do
        expect do
          post :create,
               params: { animal: valid_attributes, person_id: person.id },
               session: valid_session
        end.to change(Animal, :count).by(1)
      end

      it 'redirects to the created animal' do
        post :create,
             params: { animal: valid_attributes, person_id: person.id },
             session: valid_session

        expect(response).to redirect_to(
          person_animal_path(person, Animal.last)
        )
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Coragem',
          monthly_cost: BigDecimal(1000),
          person_id: person.id,
          animal_type_id: animal_type.id
        }
      end

      it 'updates the requested animal' do
        animal = Animal.create! valid_attributes

        put :update,
            params: {
              id: animal.to_param,
              animal: new_attributes,
              person_id: person.id
            },
            session: valid_session

        animal.reload

        expect(animal.attributes.except('id', 'created_at', 'updated_at'))
          .to eq(new_attributes.stringify_keys)
      end

      it 'redirects to the animal' do
        animal = Animal.create! valid_attributes

        put :update,
            params: {
              id: animal.to_param,
              animal: valid_attributes,
              person_id: person.id
            },
            session: valid_session

        expect(response).to redirect_to(
          person_animal_path(person, Animal.last)
        )
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested animal' do
      animal = Animal.create! valid_attributes
      expect do
        delete :destroy,
               params: { id: animal.to_param, person_id: person.id },
               session: valid_session
      end.to change(Animal, :count).by(-1)
    end

    it 'redirects to the animals list' do
      animal = Animal.create! valid_attributes

      delete :destroy,
             params: { id: animal.to_param, person_id: person.id },
             session: valid_session

      expect(response).to redirect_to(
        person_animals_path(person)
      )
    end
  end
end
