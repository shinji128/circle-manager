class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :event

  enum state: { present: 0, absent: 1, undecided: 2 }
end
