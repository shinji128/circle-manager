class Event < ApplicationRecord
  belongs_to :circle
  has_many :event_roles, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :matches, dependent: :destroy
  has_many :match_results, dependent: :destroy

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

  #現在の試合の中でユーザーが重複していないか確認
  def check_duplication_member(match)
    match_check = self.match_array.flatten
    match.each do |m|
      match_check = match_check - [m]
    end
    match_check.count == self.match_array.flatten.count
  end

  #現在の試合の中で試合が重複していないか確認
  def check_duplication_match(match)
    match_check = [match[0], match[1], match[2], match[3]]
    self.match_array.count == (self.match_array - match_check).count
  end

  #過去の試合と重複していないか確認
  def check_duplication_match_result(match)
    if !self.match_results.empty?
      match_check = [match[0], match[1], match[2], match[3]]
      !self.match_result_array.include?(match_check)
    else
      true
    end
  end

  #二次元配列で現在の試合を配列化
  def match_array
    match_set = []
    self.matches.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    match_set
  end

  #二次元配列で過去の試合を配列化
  def match_result_array
    match_set = []
    self.match_results.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    match_set
  end

  #viewsで使用 eventに紐付いたidを表示
  def player_attendance_id(player)
    self.attendances.absent.find_by(user_id: player)
  end

  #viewsで使用 ユーザーの試合回数を算出
  def match_count(user)
    self.match_result_array.flatten.count(user.user_id)
  end

  #viewsで使用 ユーザーの試合回数を算出
  def match_count_player(user)
    self.match_result_array.flatten.count(user)
  end
end
