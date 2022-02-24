class AffiliationsController < ApplicationController
  skip_before_action :require_login

  def new; end

  def create
    if logged_in?
      @circle = Circle.find(params[:circle_id])
      @affiliation = @circle.affiliations.new(circle_id: @circle.id, user_id: current_user.id)
      if !Affiliation.find_by(user_id: current_user.id, circle_id: @circle.id)
        @affiliation.save
        redirect_to circle_path(@circle), notice: 'サークルに入会しました'
      else
        redirect_to circle_path(@circle), alert: 'あなたはすでにメンバーです'
      end
    else
      redirect_to auth_at_provider_path(:provider => :line)
    end
  end
end
