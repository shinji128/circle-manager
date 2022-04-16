class MatchesController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    play_num = params[:match][:play_num]
    if 4 * play_num.to_i > event.attendances.absent.count
      flash[:alert] = 'コート数を減らしてください'
      redirect_to circle_event_matches_path(event.circle, event)
    elsif play_num.to_i == 0
      flash[:alert] = 'コート数を入力してください'
      redirect_to circle_event_matches_path(event.circle, event)
    else
      event.matches.destroy_all
      member = event.attendances.absent.pluck(:user_id)
      pairs = member.combination(2).to_a
      round_robin = []
      pairs.combination(2).to_a.each do |i|
        if i.flatten.uniq.count == 4
          round_robin << [i[0][0], i[0][1], i[1][0], i[1][1]]
        end
      end
      match = round_robin.shuffle.first
      if event.check_duplication_match_result(match)
        event.matches.create(event_id: event.id, user_a: match[0], user_b: match[1], user_c: match[2], user_d: match[3])
      end
      loop do
        if play_num.to_i == event.matches.count
          break
        end
        match = round_robin.shuffle.first
        if event.check_duplication_match(match) && event.check_duplication_member(match)
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
    @match_results = @event.match_results
    @play_num = @event.matches.new
  end
end
