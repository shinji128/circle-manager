class AffiliationsController < ApplicationController
  def index
    @circle = Circle.find(params[:circle_id])
    if current_user.circle_member?(@circle)
      @affiliation_admins = @circle.affiliations.admin.includes(:user).order(created_at: :asc)
      @affiliation_generals = @circle.affiliations.general.includes(:user).order(created_at: :asc)
    else
      flash.now[:alert] = 'サークルメンバーだけが閲覧できます'
    end
  end

  def new
    @circle = Circle.find_by(uuid: params[:uuid])
  end

  def create
    if logged_in?
      @circle = Circle.find_by(uuid: params[:uuid])
      if @circle.blank?
        redirect_to root_path, alert: '不正な招待リンクです'
      else
        @affiliation = @circle.affiliations.new(circle_id: @circle.id, user_id: current_user.id)
        if Affiliation.find_by(user_id: current_user.id, circle_id: @circle.id)
          redirect_to circle_path(@circle), alert: 'あなたはすでにメンバーです'
        else
          @affiliation.save
          redirect_to circle_path(@circle), notice: 'サークルに入会しました'
        end
      end
    else
      redirect_to auth_at_provider_path(provider: :line)
    end
  end

  def show
    @affiliation = Affiliation.find(params[:id])
    @circle = @affiliation.circle
    @user = @affiliation.user
    redirect_to circle_path(@circle) unless current_user.circle_member?(@circle)
  end

  def edit
    @affiliation = current_user.affiliations.find(params[:id])
    @user = @affiliation.user
  end

  def update
    @affiliation = current_user.affiliations.find(params[:id])
    if @affiliation.update(introduction: params[:affiliation][:introduction])
      redirect_to circle_affiliations_path(@affiliation.circle), notice: 'サークルの自己紹介文を更新しました'
    else
      render :edit
    end
  end

  def circle_admin_assign
    @circle = Circle.find(params[:circle_id])
    if current_user.circle_admin?(@circle)
      @affiliation = @circle.affiliations.find(params[:id])
      @affiliation.update(circle_state: 1)
    end
    redirect_to circle_affiliations_path(@circle)
  end

  def destroy
    circle = Circle.find(params[:circle_id])
    affiliation = @circle.affiliations.find_by(user_id: current_user.id)
    affiliation.destroy!
    redirect_to root_path, notice: 'サークルを退会しました'
  end

  def circle_admin_retire
    @circle = Circle.find(params[:circle_id])
    if current_user.circle_admin?(@circle)
      @affiliation = @circle.affiliations.find(params[:id])
      @affiliation.update(circle_state: 0)
    end
    redirect_to circle_affiliations_path(@circle)
  end
end
