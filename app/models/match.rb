class Match < ApplicationRecord
  belongs_to :event

  enum state: { unfixed: 0, fixed: 1, past: 2 }

  def attendance_user(player)
    User.find(player.to_i)
  end
end
