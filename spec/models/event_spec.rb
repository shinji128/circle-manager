require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'validation' do
    it 'is valid with all attributes' do
      event = build(:event)
      expect(event).to be_valid
      expect(event.errors).to be_empty
    end

    it 'is invalid without name' do
      event_without_title = build(:event, name: "")
      expect(event_without_title).to be_invalid
      expect(event_without_title.errors[:name]).to eq ["を入力してください"]
    end
  end
end
