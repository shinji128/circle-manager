class Event < ApplicationRecord
  belongs_to :circle
  has_many :event_roles
  has_many :attendances
  has_many :matches
  has_many :match_counts
  has_many :match_results

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

  def check_duplication_member(match)
    match_set = []
    self.matches.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    match_array = match_set.flatten
    match.each do |m|
      match_array = match_array - [m]
    end
    match_array.count == match_set.flatten.count
  end

  def check_duplication_match(match)
    match_set = []
    self.matches.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    match_check = [match[0], match[1], match[2], match[3]]
    match_set.count == (match_set - match_check).count
  end

  def check_duplication_match_result(match)
    if !self.match_results.empty?
      match_set = []
      self.match_results.each do |m|
        match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
      end
      match_check = [match[0], match[1], match[2], match[3]]
      !match_set.include?(match_check)
    else
      true
    end
  end
end
