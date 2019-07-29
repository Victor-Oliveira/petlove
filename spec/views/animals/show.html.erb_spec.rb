# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'animals/show', type: :view do
  let(:animal_type) { create(:animal_type) }

  before(:each) do
    @person = assign(:person, create(:person))

    @animal = assign(:animal, Animal.create!(
                                name: 'Name',
                                monthly_cost: '9.99',
                                person_id: @person.id,
                                animal_type_id: animal_type.id
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/#{@person.name}/)
    expect(rendered).to match(/#{animal_type.name}/)
  end
end
