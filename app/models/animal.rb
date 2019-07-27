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

class Animal < ApplicationRecord
  belongs_to :person
  belongs_to :animal_type

  validates_presence_of :name, :monthly_cost

  validates_with AnimalValidator
end
