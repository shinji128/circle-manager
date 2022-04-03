class MatchResultsController < ApplicationController

  def match_decide
    event = Event.find(params[:id])
    event.matches.each do |match|
      if event.check_duplication_match_result(match)
        event.match_results.create(event_id: event.id, user_a: match.user_a, user_b: match.user_b, user_c: match.user_c, user_d: match.user_d)
      else
        flash[:alert] = 'すでに確定している試合です'
      end
    end
    flash[:notice] = '試合を確定しました'
    redirect_to circle_event_matches_path(event.circle, event)
  end
end