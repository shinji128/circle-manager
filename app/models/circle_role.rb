class CircleRole < ApplicationRecord
  belongs_to :circle

  validates :name, presence: true
end
