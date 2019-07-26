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

class Person < ApplicationRecord
  has_many :animals

  validates_presence_of :name, :paper_number, :birth_date

  def initial_letter
    name[0]
  end

  def total_monthly_cost
    animals.map(&:monthly_cost).sum
  end

  def over_monthly_cost?
    total_monthly_cost > ENV['MAX_TOTAL_ANIMAL_COST'].to_i
  end

  def age
    ((Time.now - birth_date.to_time) / 1.year.seconds).floor
  end

  def not_allowed_by_initial?(animal_type)
    not_allowed_initials = ENV['NOT_ALLOWED_INITIALS'].to_s.split(',')
    not_allowed_animal_types = ENV['ANIMAL_TYPES_NOT_ALLOWED_BY_INITIAL']
      .to_s.split(',')

    if not_allowed_initials.include?(initial_letter) &&
        not_allowed_animal_types.include?(animal_type)
      return true
    end

    false
  end

  def not_allowed_by_age?(animal_type)
    minimum_age = ENV['MINIMUM_AGE'].to_i

    not_allowed_animal_types = ENV[
      'ANIMAL_TYPES_NOT_ALLOWED_BELLOW_MINIMUM_AGE'
    ].to_s.split(',')

    return true if age < minimum_age && not_allowed_animal_types
      .include?(animal_type)

    false
  end
end
