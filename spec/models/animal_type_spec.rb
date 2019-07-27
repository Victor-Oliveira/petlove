# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AnimalType, type: :model do
  it { is_expected.to have_many(:animals) }
end
