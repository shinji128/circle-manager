require 'rails_helper'

RSpec.describe Match, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      match = build(:match)
      expect(match).to be_valid
      expect(match.errors).to be_empty
    end
  end
end
