# frozen_string_literal: true

# == Schema Information
#
# Table name: animals
#
#  id             :bigint           not null, primary key
#  name           :string
#  monthly_cost   :decimal(10, 2)
#  person_id      :bigint
#  animal_type_id :bigint
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :animal do
    name { 'MyString' }
    monthly_cost { '10.00' }
    person
    animal_type
  end
end
