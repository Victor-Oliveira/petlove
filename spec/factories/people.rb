# frozen_string_literal: true

# == Schema Information
#
# Table name: people
#
#  id           :bigint           not null, primary key
#  name         :string
#  paper_number :string
#  birth_date   :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

FactoryBot.define do
  factory :person do
    name { 'Pessoa' }
    paper_number { '1111111' }
    birth_date { '1994-07-25' }
  end

  trait :with_animal do
    animals { [create(:animal)] }
  end

  trait :with_animals do
    animals { create_list(:animal, 3) }
  end
end
