# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalTypesController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Cachorro'
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      AnimalType.create! valid_attributes

      get :index, params: {}, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      animal_type = AnimalType.create! valid_attributes

      get :show, params: { id: animal_type.to_param }, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'GET #edit' do
    it 'returns a success response' do
      animal_type = AnimalType.create! valid_attributes

      get :edit, params: { id: animal_type.to_param }, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new AnimalType' do
        expect do
          post :create,
               params: { animal_type: valid_attributes },
               session: valid_session
        end.to change(AnimalType, :count).by(1)
      end

      it 'redirects to the created animal_type' do
        post :create,
             params: { animal_type: valid_attributes },
             session: valid_session

        expect(response).to redirect_to(AnimalType.last)
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Gato'
        }
      end

      it 'updates the requested animal_type' do
        animal_type = AnimalType.create! valid_attributes

        put :update,
            params: { id: animal_type.to_param, animal_type: new_attributes },
            session: valid_session

        animal_type.reload

        expect(animal_type.attributes.except('id', 'created_at', 'updated_at'))
          .to eq(new_attributes.stringify_keys)
      end

      it 'redirects to the animal_type' do
        animal_type = AnimalType.create! valid_attributes

        put :update,
            params: { id: animal_type.to_param, animal_type: valid_attributes },
            session: valid_session

        expect(response).to redirect_to(animal_type)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested animal_type' do
      animal_type = AnimalType.create! valid_attributes
      expect do
        delete :destroy,
               params: { id: animal_type.to_param },
               session: valid_session
      end.to change(AnimalType, :count).by(-1)
    end

    it 'redirects to the animal_types list' do
      animal_type = AnimalType.create! valid_attributes

      delete :destroy,
             params: { id: animal_type.to_param },
             session: valid_session

      expect(response).to redirect_to(animal_types_url)
    end
  end
end
