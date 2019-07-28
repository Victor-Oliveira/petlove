# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'People', type: :request do
  describe 'GET /people' do
    it 'returns a success response' do
      get people_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /people/:id' do
    let(:person) { create(:person) }

    it 'returns a success response' do
      get person_path(person.id)

      expect(response).to have_http_status(200)
    end

    it 'returns the person\'s info' do
      get person_path(person.id)

      expect(response.body).to include(person.name)
      expect(response.body).to include(person.paper_number)
      expect(response.body).to include(I18n.l(person.birth_date))
    end
  end

  describe 'POST /people' do
    it 'creates a person' do
      get new_person_path

      expect(response).to render_template(:new)

      post people_path,
           params: {
             person: {
               name: 'Pessoa',
               paper_number: '123123',
               birth_date: Date.new(1990, 1, 1)
             }
           }

      expect(response).to redirect_to(assigns(:person))
    end

    it 'redirects to the Person\'s show page and flashes creation message' do
      get new_person_path
      expect(response).to render_template(:new)

      post people_path,
           params: {
             person: {
               name: 'Pessoa',
               paper_number: '123123',
               birth_date: Date.new(1990, 1, 1)
             }
           }

      expect(response).to redirect_to(assigns(:person))

      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include(
        I18n.t(:create, model: I18n.t('activerecord.models.person.one'))
      )
    end
  end

  describe 'PUT /people/:id' do
    let(:person) { create(:person) }

    it 'updates a person' do
      get edit_person_path(person.id)

      expect(response).to render_template(:edit)

      put person_path(person.id),
          params: {
            person: {
              name: 'Outro nome',
              paper_number: '11111111',
              birth_date: Date.new(1980, 5, 5)
            }
          }

      expect(response).to redirect_to(assigns(:person))

      follow_redirect!

      expect(response.body).to include('Outro nome')
      expect(response.body).to include('11111111')
      expect(response.body).to include(I18n.l(Date.new(1980, 5, 5)))
    end

    it 'redirects to the Person\'s show page and flashes udpate message' do
      get edit_person_path(person.id)

      expect(response).to render_template(:edit)

      put person_path(person.id),
          params: {
            person: {
              name: 'Outro nome',
              paper_number: '11111111',
              birth_date: Date.new(1980, 5, 5)
            }
          }

      expect(response).to redirect_to(assigns(:person))

      follow_redirect!

      expect(response).to render_template(:show)
      expect(response.body).to include(
        I18n.t(:update, model: I18n.t('activerecord.models.person.one'))
      )
    end
  end

  describe 'DELETE /people/:id' do
    let(:person) { create(:person) }

    it 'deletes a person' do
      delete person_path(person.id)

      expect(response).to redirect_to(assigns(:person))

      expect { Person.find(person.id) }
        .to raise_exception(ActiveRecord::RecordNotFound)
    end

    it 'redirects to the People\'s index page and flashes deletion message' do
      delete person_path(person.id)

      expect(response).to redirect_to(assigns(:person))

      follow_redirect!

      expect(Person.count).to eq(0)
      expect(response).to render_template(:index)
      expect(response.body).to include(
        I18n.t(:delete, model: I18n.t('activerecord.models.person.one'))
      )
    end
  end
end
