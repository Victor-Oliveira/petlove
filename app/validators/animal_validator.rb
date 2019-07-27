# frozen_string_literal: true

class AnimalValidator < ActiveModel::Validator
  def validate(record)
    @record = record
    @person = record.person_id ? Person.find(record.person_id) : record.person

    validate_max_monthly_cost
    validate_initial_and_animal_type
    validate_age_and_animal_type
  end

  private

  # rubocop:disable Style/GuardClause
  def validate_max_monthly_cost
    if @person&.over_monthly_cost?
      @record.errors.add(:base, :over_monthly_cost, person: @person.name)
    end
  end
  # rubocop:enable Style/GuardClause

  # rubocop:disable Style/GuardClause
  def validate_initial_and_animal_type
    if @person&.not_allowed_by_initial?(@record.animal_type.name)
      @record.errors.add(
        :base,
        :type_not_allowed_by_initial,
        person: @person.name,
        animal_type: @record.animal_type.name,
        initial_letter: @person.initial_letter
      )
    end
  end
  # rubocop:enable Style/GuardClause

  # rubocop:disable Style/GuardClause
  def validate_age_and_animal_type
    if @person&.not_allowed_by_age?(@record.animal_type.name)
      @record.errors.add(
        :base,
        :not_allowed_by_person_minimum_age,
        minimum_age: ENV['MINIMUM_AGE'],
        animal_type: @record.animal_type.name
      )
    end
  end
  # rubocop:enable Style/GuardClause
end
