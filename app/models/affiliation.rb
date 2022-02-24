class Affiliation < ApplicationRecord
  belongs_to :user
  belongs_to :circle

  validates :user_id, uniqueness: { scope: :circle_id }
  validates :introduction, length: { maximum: 65_535 }
end
