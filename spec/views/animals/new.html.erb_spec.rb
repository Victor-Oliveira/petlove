# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'animals/new', type: :view do
  let(:animal_type) { create(:animal_type) }

  before(:each) do
    @person = assign(:person, create(:person))

    @animal = assign(:animal, Animal.new(
                                name: 'MyString',
                                monthly_cost: '9.99',
                                person_id: @person.id,
                                animal_type_id: animal_type.id
                              ))
  end

  it 'renders new animal form' do
    render

    assert_select 'form[action=?][method=?]',
                  person_animals_path(@person, @animal), 'post' do
      assert_select 'input[name=?]', 'animal[name]'

      assert_select 'input[name=?]', 'animal[monthly_cost]'

      assert_select 'input[name=?]', 'animal[person_id]'

      assert_select 'select[name=?]', 'animal[animal_type_id]'
    end
  end
end
