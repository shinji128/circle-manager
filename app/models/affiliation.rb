class Affiliation < ApplicationRecord
  belongs_to :user
  belongs_to :circle

  validates :user_id, uniqueness: { scope: :circle_id }
  validates :introduction, length: { maximum: 65_535 }

  enum circle_state: { general: 0, admin: 1 }
end
