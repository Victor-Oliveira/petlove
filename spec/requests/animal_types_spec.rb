# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'AnimalTypes', type: :request do
  describe 'GET /animal_types' do
    it 'returns a success response' do
      get animal_types_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /animal_types/:id' do
    let(:animal_type) { create(:animal_type) }

    it 'returns a success response' do
      get animal_type_path(animal_type.id)

      expect(response).to have_http_status(200)
    end

    it 'returns the animal_type\'s info' do
      get animal_type_path(animal_type.id)

      expect(response.body).to include(animal_type.name)
    end
  end

  describe 'POST /animal_type' do
    it 'creates an animal_type' do
      get new_animal_type_path

      expect(response).to render_template(:new)

      post animal_types_path,
           params: {
             animal_type: {
               name: 'Cachorro'
             }
           }

      expect(response).to redirect_to(assigns(:animal_type))
    end

    it 'redirects to the Animal type\'s show page and flashes creation msg' do
      get new_animal_type_path

      expect(response).to render_template(:new)

      post animal_types_path,
           params: {
             animal_type: {
               name: 'Cachorro'
             }
           }

      expect(response).to redirect_to(assigns(:animal_type))

      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include(
        I18n.t(:create, model: I18n.t('activerecord.models.animal_type.one'))
      )
    end
  end

  describe 'PUT /animal_types/:id' do
    let(:animal_type) { create(:animal_type) }

    it 'updates an animal type' do
      get edit_animal_type_path(animal_type.id)

      expect(response).to render_template(:edit)

      put animal_type_path(animal_type.id),
          params: {
            animal_type: {
              name: 'Gato'
            }
          }

      expect(response).to redirect_to(assigns(:animal_type))
    end

    it 'redirects to the Animal type\'s show page and flashes update msg' do
      get edit_animal_type_path(animal_type.id)

      expect(response).to render_template(:edit)

      put animal_type_path(animal_type.id),
          params: {
            animal_type: {
              name: 'Gato'
            }
          }

      expect(response).to redirect_to(assigns(:animal_type))

      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include(
        I18n.t(:update, model: I18n.t('activerecord.models.animal_type.one'))
      )
    end
  end

  describe 'DELETE /animal_types/:id' do
    let(:animal_type) { create(:animal_type) }

    it 'deletes an animal type' do
      delete animal_type_path(animal_type.id)

      expect(response).to redirect_to(assigns(:animal_type))

      expect { AnimalType.find(animal_type.id) }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'redirects to the Animal Type\'s index page and flashes deletion msg' do
      delete animal_type_path(animal_type.id)

      expect(response).to redirect_to(assigns(:animal_type))

      follow_redirect!

      expect(Person.count).to eq(0)
      expect(response).to render_template(:index)
      expect(response.body).to include(
        I18n.t(:delete, model: I18n.t('activerecord.models.animal_type.one'))
      )
    end
  end
end
