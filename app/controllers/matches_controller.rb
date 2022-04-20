class MatchesController < ApplicationController

  def create
    event = Event.find(params[:event_id])

    # コート数を受け取る
    play_num = params[:match][:play_num]

    # コートの数が0またはコートが余ってしまった時にエラーを吐き出す JSでコート数が適切な場合のみボタンを有効化する？
    if 4 * play_num.to_i > event.attendances.absent.count
      flash[:alert] = 'コート数を減らしてください'
      redirect_to circle_event_matches_path(event.circle, event)
    elsif play_num.to_i == 0
      flash[:alert] = 'コート数を入力してください'
      redirect_to circle_event_matches_path(event.circle, event)
    else

      # 現在の組み合わせを削除
      event.matches.destroy_all

      # ペアを作成
      member = event.attendances.absent.pluck(:user_id)
      pairs = member.combination(2).to_a

      # 試合の組み合わせを作成 一つの試合でユーザーが重複しないように
      round_robin = []
      pairs.combination(2).to_a.each do |i|
        if i.flatten.uniq.count == 4
          round_robin << [i[0][0], i[0][1], i[1][0], i[1][1]]
        end
      end
      match = round_robin.shuffle.first

      #過去に試合同じ試合の組み合わせがあるか確認、なければ作成
      if event.check_duplication_match_result(match)
        event.matches.create(event_id: event.id, user_a: match[0], user_b: match[1], user_c: match[2], user_d: match[3])
      end

      #過去の試合、現在の試合、現在の試合のユーザーで重複した組み合わせがなければ試合を作成
      loop do
        if play_num.to_i == event.matches.count
          break
        end
        match = round_robin.shuffle.first
        if event.check_duplication_match(match) && event.check_duplication_member(match) && event.check_duplication_match_result(match)
          event.matches.create(event_id: event.id, user_a: match[0], user_b: match[1], user_c: match[2], user_d: match[3])
        end
      end
      flash[:notice] = 'シャッフルしました'
      redirect_to circle_event_matches_path(event.circle, event)
    end
  end

  def show
    @event = Event.find(params[:event_id])
    @members = []
    @event.attendances.absent.each do |m|
      if !@event.match_array.flatten.include?(m.user_id)
        @members << m
      end
    end
    @matches = @event.matches.includes(:event)
    @match_results = @event.match_results.new
    @play_num = @event.matches.new
  end
end
