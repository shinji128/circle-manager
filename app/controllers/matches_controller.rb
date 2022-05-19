class MatchesController < ApplicationController
  def create
    event = Event.find(params[:event_id])
    event.matches.unfixed.destroy_all
    court_num = params[:match][:court_num]
    if 4 * court_num.to_i > event.attendances.absent.count
      redirect_to event_matches_path(event), alert: 'コート数を減らしてください'
    elsif court_num.to_i.zero?
      redirect_to event_matches_path(event), alert: 'コート数を入力してください'
    else
      matches = event.matches_make.shuffle
      match = matches.sample
      if event.matches.empty?
        event.matches.create(state: 0, user_a: match[0], user_b: match[1], user_c: match[2], user_d: match[3])
      end
      matches.each do |m|
        if court_num.to_i == event.matches.unfixed.count
          break
        end

        if event.check_duplication_match(m) && event.check_duplication_member(m)
          event.matches.create(state: 0, user_a: m[0], user_b: m[1], user_c: m[2], user_d: m[3])
        end
      end
      redirect_to event_matches_path(event), notice: 'シャッフルしました'
    end
  end

  def match_fixed
    event = Event.find(params[:event_id])
    if params[:match].nil?
      redirect_to event_matches_path(event), alert: '未確定の試合が存在しません'
    else
      event.matches.fixed.update(state: 2)
      event.matches.unfixed.destroy_all
      params[:match][:matches].each do |i|
        user_a = event.attendances.absent.find(i['user_a']).user.id
        user_b = event.attendances.absent.find(i['user_b']).user.id
        user_c = event.attendances.absent.find(i['user_c']).user.id
        user_d = event.attendances.absent.find(i['user_d']).user.id
        event.matches.create(state: 1, user_a: user_a, user_b: user_b, user_c: user_c, user_d: user_d)
      end
      redirect_to event_matches_path(event), notice: '試合を確定しました'
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @members = []
    @event.attendances.absent.each do |m|
      unless @event.match_unfixed_array.flatten.include?(m.user_id)
        @members << m
      end
    end
    @matches = @event.matches.includes(:event)
    @match = @event.matches.new
    @court_num = @event.matches.new
  end

  def destroy
    event = Event.find(params[:circle_id])
    event.matches.destroy_all
    redirect_to event_matches_path(event), notice: '試合をリセットしました'
  end
end
