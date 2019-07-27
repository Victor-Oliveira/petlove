# frozen_string_literal: true

class AnimalType < ApplicationRecord
  has_many :animals
end
