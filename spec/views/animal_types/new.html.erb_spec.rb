# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'animal_types/new', type: :view do
  before(:each) do
    assign(:animal_type, AnimalType.new(
                           name: 'MyString'
                         ))
  end

  it 'renders new animal_type form' do
    render

    assert_select 'form[action=?][method=?]', animal_types_path, 'post' do
      assert_select 'input[name=?]', 'animal_type[name]'
    end
  end
end
