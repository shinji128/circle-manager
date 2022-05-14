require 'rails_helper'

RSpec.describe Circle, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      circle = build(:circle)
      expect(circle).to be_valid
      expect(circle.errors).to be_empty
    end

    it 'is invalid without name' do
      circle_without_title = build(:circle, name: "")
      expect(circle_without_title).to be_invalid
      expect(circle_without_title.errors[:name]).to eq ["を入力してください"]
    end
  end
end
