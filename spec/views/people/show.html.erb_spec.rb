# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'people/show', type: :view do
  before(:each) do
    @person = assign(:person, Person.create!(
                                name: 'Name',
                                paper_number: 'Paper Number',
                                birth_date: Date.new(1960, 4, 4)
                              ))
  end

  it 'renders attributes in <p>' do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Paper Number/)
  end
end
