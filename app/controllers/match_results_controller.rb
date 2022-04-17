class MatchResultsController < ApplicationController

  def create
    event = Event.find(params[:event_id])
    event.matches.destroy_all
    params[:match_result][:match_results].each do |i|
      user_a = event.attendances.absent.find(i['user_a']).user.id
      user_b = event.attendances.absent.find(i['user_b']).user.id
      user_c = event.attendances.absent.find(i['user_c']).user.id
      user_d = event.attendances.absent.find(i['user_d']).user.id
      event.match_results.create(user_a: user_a, user_b: user_b, user_c: user_c, user_d: user_d)
      event.matches.create(user_a: user_a, user_b: user_b, user_c: user_c, user_d: user_d)
    end
    flash[:notice] = '試合を確定しました'
    redirect_to circle_event_matches_path(event.circle, event)
  end
end