class AffiliationsController < ApplicationController
  def new; end

  def create
    @circle = Circle.find(params[:circle_id])
    @affiliation = @circle.affiliations.new(circle_id: @circle.id, user_id: current_user.id)
    if !Affiliation.find_by(user_id: current_user.id, circle_id: @circle.id)
      @affiliation.save
      redirect_to circle_path(@circle) #フラッシュメッセージ @circle.nameに参加しました
    else
      redirect_to circle_path(@circle) #フラッシュメッセージ すでにメンバーです
    end
  end
end
