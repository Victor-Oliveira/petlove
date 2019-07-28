# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'people/index', type: :view do
  before(:each) do
    assign(:people, [
             Person.create!(
               name: 'Name',
               paper_number: 'Paper Number',
               birth_date: Date.new(1990, 2, 5)
             ),
             Person.create!(
               name: 'Name',
               paper_number: 'Paper Number',
               birth_date: Date.new(1990, 2, 5)
             )
           ])
  end

  it 'renders a list of people' do
    render
    assert_select 'tr>td', text: 'Name'.to_s, count: 2
    assert_select 'tr>td', text: 'Paper Number'.to_s, count: 2
  end
end
