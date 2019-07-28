# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'animal_types/show', type: :view do
  before(:each) do
    @animal_type = assign(:animal_type, AnimalType.create!(
                                          name: 'Name'
                                        ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
  end
end
