# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'animal_types/index', type: :view do
  before(:each) do
    assign(:animal_types, [
             AnimalType.create!(
               name: 'Name'
             ),
             AnimalType.create!(
               name: 'Name'
             )
           ])
  end

  it 'renders a list of animal_types' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
  end
end
