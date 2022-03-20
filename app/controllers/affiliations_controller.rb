class AffiliationsController < ApplicationController

  def new; end

  def create
    if logged_in?
      @circle = Circle.find_by(uuid: params[:uuid])
      if @circle.blank?
        redirect_to root_path, alert: '不正な招待リンクです'
      else
        @affiliation = @circle.affiliations.new(circle_id: @circle.id, user_id: current_user.id)
        if !Affiliation.find_by(user_id: current_user.id, circle_id: @circle.id)
          @affiliation.save
          redirect_to circle_path(@circle), notice: 'サークルに入会しました'
        else
          redirect_to circle_path(@circle), alert: 'あなたはすでにメンバーです'
        end
      end
    else
      redirect_to auth_at_provider_path(:provider => :line)
    end
  end
end
