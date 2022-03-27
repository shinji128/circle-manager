class Event < ApplicationRecord
  belongs_to :circle
  has_many :event_roles
  has_many :attendances

  validates :name, presence: true

  def attendance_answer?(current_user)
    self.attendances.pluck(:user_id).include?(current_user.id)
  end

  def attendance_state(current_user)
    if self.attendances.find_by(user_id: current_user.id)
      self.attendances.find_by(user_id: current_user.id).state_i18n
    else
      Attendance.states_i18n['no_exit']
    end
  end
end
