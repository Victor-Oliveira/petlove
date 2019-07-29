# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'animals/index', type: :view do
  let(:animal_type) { create(:animal_type) }

  before(:each) do
    @person = assign(:person, create(:person))

    assign(:animals, [
             Animal.create!(
               name: 'Name',
               monthly_cost: '9.99',
               person_id: @person.id,
               animal_type_id: animal_type.id
             ),
             Animal.create!(
               name: 'Name',
               monthly_cost: '9.99',
               person_id: @person.id,
               animal_type_id: animal_type.id
             )
           ])
  end

  it 'renders a list of animals' do
    render template: '/animals/index.html.erb',
           locals: { person_id: @person.id }

    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: '9.99'.to_s, count: 2
    assert_select 'tr>td', text: @person.name.to_s.to_s, count: 2
    assert_select 'tr>td', text: animal_type.name.to_s.to_s, count: 2
  end
end
