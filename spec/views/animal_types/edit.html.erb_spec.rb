# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'animal_types/edit', type: :view do
  before(:each) do
    @animal_type = assign(:animal_type, AnimalType.create!(
                                          name: 'MyString'
                                        ))
  end

  it 'renders the edit animal_type form' do
    render

    assert_select 'form[action=?][method=?]',
                  animal_type_path(@animal_type), 'post' do
      assert_select 'input[name=?]', 'animal_type[name]'
    end
  end
end
