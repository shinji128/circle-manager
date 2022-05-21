class Event < ApplicationRecord
  belongs_to :circle
  has_many :event_roles, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :matches, dependent: :destroy

  validates :name, presence: true

  def attendance_answer?(current_user)
    attendances.pluck(:user_id).include?(current_user.id)
  end

  def attendance_state(current_user)
    if attendances.find_by(user_id: current_user.id)
      attendances.find_by(user_id: current_user.id).state_i18n
    else
      Attendance.states_i18n['no_exit']
    end
  end

  def match_unfixed_array
    match_set = []
    matches.unfixed.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    match_set
  end

  def match_fixed_array
    match_set = []
    matches.fixed.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    matches.past.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    match_set
  end

  def match_array
    match_set = []
    matches.each do |m|
      match_set << [m.user_a, m.user_b, m.user_c, m.user_d]
    end
    match_set
  end

  # 試合が重複していないか確認
  def check_duplication_match(match)
    match_check = [match[0], match[1], match[2], match[3]]
    !match_array.include?(match_check)
  end

  # 現在の試合の中でユーザーが重複していないか確認
  def check_duplication_member(match)
    match_check = match_unfixed_array.flatten
    match.each do |m|
      match_check -= [m]
    end
    match_check.count == match_unfixed_array.flatten.count
  end

  # viewsで使用 eventに紐付いたidを表示
  def player_attendance_id(member)
    attendances.absent.find_by(user_id: member.user_id)
  end

  # viewsで使用 ユーザーの試合回数を算出
  def match_count(user)
    match_fixed_array.flatten.count(user.user_id)
  end

  # viewsで使用 ユーザーの試合回数を算出
  def match_count_player(user)
    match_fixed_array.flatten.count(user)
  end

  def matches_make
    member = attendances.absent.pluck(:user_id)
    pairs = member.combination(2).to_a
    round_robin = []
    pairs.combination(2).to_a.each do |i|
      if i.flatten.uniq.count == 4
        round_robin << [i[0][0], i[0][1], i[1][0], i[1][1]]
      end
    end
    round_robin
  end
end
