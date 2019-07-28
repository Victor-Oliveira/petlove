# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalTypesController, type: :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get: '/animal_types').to route_to('animal_types#index')
    end

    it 'routes to #new' do
      expect(get: '/animal_types/new').to route_to('animal_types#new')
    end

    it 'routes to #show' do
      expect(get: '/animal_types/1').to route_to('animal_types#show', id: '1')
    end

    it 'routes to #edit' do
      expect(
        get: '/animal_types/1/edit'
      ).to route_to('animal_types#edit', id: '1')
    end

    it 'routes to #create' do
      expect(post: '/animal_types').to route_to('animal_types#create')
    end

    it 'routes to #update via PUT' do
      expect(
        put: '/animal_types/1'
      ).to route_to('animal_types#update', id: '1')
    end

    it 'routes to #update via PATCH' do
      expect(
        patch: '/animal_types/1'
      ).to route_to('animal_types#update', id: '1')
    end

    it 'routes to #destroy' do
      expect(
        delete: '/animal_types/1'
      ).to route_to('animal_types#destroy', id: '1')
    end
  end
end
