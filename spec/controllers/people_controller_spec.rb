# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PeopleController, type: :controller do
  let(:valid_attributes) do
    {
      name: 'Pessoa',
      paper_number: '1111111',
      birth_date: Date.new(1970, 1, 1)
    }
  end

  let(:invalid_attributes) do
    {
      birth_date: 1
    }
  end

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      Person.create! valid_attributes

      get :index, params: {}, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      person = Person.create! valid_attributes

      get :show, params: { id: person.to_param }, session: valid_session

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
      person = Person.create! valid_attributes

      get :edit, params: { id: person.to_param }, session: valid_session

      expect(response).to be_successful
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Person' do
        expect do
          post :create,
               params: { person: valid_attributes },
               session: valid_session
        end.to change(Person, :count).by(1)
      end

      it 'redirects to the created person' do
        post :create,
             params: { person: valid_attributes },
             session: valid_session

        expect(response).to redirect_to(Person.last)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        post :create,
             params: { person: invalid_attributes },
             session: valid_session

        expect(response).to be_successful
      end
    end
  end

  describe 'PUT #update' do
    context 'with valid params' do
      let(:new_attributes) do
        {
          name: 'Novo nome',
          paper_number: '222222',
          birth_date: Date.new(1980, 5, 5)
        }
      end

      it 'updates the requested person' do
        person = Person.create! valid_attributes

        put :update,
            params: { id: person.to_param, person: new_attributes },
            session: valid_session

        person.reload

        expect(person.attributes.except('id', 'created_at', 'updated_at'))
          .to eq(new_attributes.stringify_keys)
      end

      it 'redirects to the person' do
        person = Person.create! valid_attributes

        put :update,
            params: { id: person.to_param, person: valid_attributes },
            session: valid_session

        expect(response).to redirect_to(person)
      end
    end

    context 'with invalid params' do
      it 'returns a success response' do
        person = Person.create! valid_attributes

        put :update,
            params: { id: person.to_param, person: invalid_attributes },
            session: valid_session

        expect(response).to be_successful
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'destroys the requested person' do
      person = Person.create! valid_attributes

      expect do
        delete :destroy,
               params: { id: person.to_param },
               session: valid_session
      end.to change(Person, :count).by(-1)
    end

    it 'redirects to the people list' do
      person = Person.create! valid_attributes

      delete :destroy, params: { id: person.to_param }, session: valid_session

      expect(response).to redirect_to(people_url)
    end
  end
end
