class MatchesController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    event.matches.unfixed.destroy_all
    # コート数を受け取る
    court_num = params[:match][:court_num]
    # コートの数が0またはコートが余ってしまった時にエラーを吐き出す JSでコート数が適切な場合のみボタンを有効化する？
    if 4 * court_num.to_i > event.attendances.absent.count
      flash[:alert] = 'コート数を減らしてください'
      redirect_to event_matches_path(event)
    elsif court_num.to_i == 0
      flash[:alert] = 'コート数を入力してください'
      redirect_to event_matches_path(event)
    else
      # 組み合わせ作成
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
      flash[:notice] = 'シャッフルしました'
      redirect_to event_matches_path(event)
    end
  end

  def match_fixed
    event = Event.find(params[:event_id])
    if params[:match].nil?
      flash[:alert] = '未確定の試合が存在しません'
      redirect_to event_matches_path(event)
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
      flash[:notice] = '試合を確定しました'
      redirect_to event_matches_path(event)
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @members = []
    @event.attendances.absent.each do |m|
      if !@event.match_unfixed_array.flatten.include?(m.user_id)
        @members << m
      end
    end
    @matches = @event.matches.includes(:event)
    @match = @event.matches.new
    @court_num = @event.matches.new
  end
end
