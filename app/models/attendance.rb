class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :comment, length: { maximum: 65_535 }

  enum state: { present: 0, absent: 1, undecided: 2 }
end
