# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'home/index.html.erb', type: :view do
  it 'renders links to people and animal types' do
    render

    assert_select 'div',
                  text: t(
                    'home.list', model: t('activerecord.models.person.other')
                  )
    assert_select 'div',
                  text: t(
                    'home.list',
                    model: t('activerecord.models.animal_type.other')
                  )
  end
end
