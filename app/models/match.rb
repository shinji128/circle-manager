class Match < ApplicationRecord
  belongs_to :event

  def attendance_user(player)
    User.find(player.to_i)
  end
end
