# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalsController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: 'people/1/animals')
        .to route_to('animals#index', person_id: '1')
    end

    it 'routes to #new' do
      expect(get: 'people/1/animals/new')
        .to route_to('animals#new', person_id: '1')
    end

    it 'routes to #show' do
      expect(get: 'people/1/animals/1')
        .to route_to('animals#show', id: '1', person_id: '1')
    end

    it 'routes to #edit' do
      expect(get: 'people/1/animals/1/edit')
        .to route_to('animals#edit', id: '1', person_id: '1')
    end

    it 'routes to #create' do
      expect(post: 'people/1/animals')
        .to route_to('animals#create', person_id: '1')
    end

    it 'routes to #update via PUT' do
      expect(put: 'people/1/animals/1')
        .to route_to('animals#update', id: '1', person_id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(patch: 'people/1/animals/1')
        .to route_to('animals#update', id: '1', person_id: '1')
    end

    it 'routes to #destroy' do
      expect(delete: 'people/1/animals/1')
        .to route_to('animals#destroy', id: '1', person_id: '1')
    end
  end
end
