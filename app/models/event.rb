class Event < ApplicationRecord
  belongs_to :circle
  has_many :event_roles
  has_many :attendances

  validates :name, presence: true

  def attendance_answer?(current_user)
    self.attendances.pluck(:user_id).include?(current_user.id)
  end
end
