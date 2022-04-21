class CirclesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]

  def index
    @circles = Circle.publish.with_attached_top_image.order(created_at: :desc)
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = current_user.circles.new(circle_params)
    if @circle.save
      Affiliation.create(user: current_user, circle: @circle, circle_state: 1)
      redirect_to circle_path(@circle), notice: 'サークルを設立しました'
    else
      render :new
    end
  end

  def edit
    @circle = Circle.find(params[:id])
    redirect_to circle_path(@circle) if current_user.circle_admin?(@circle)
  end

  def update
    @circle = Circle.find(params[:id])
    if current_user.circle_admin?(@circle)
      ActiveRecord::Base.transaction do
        if params[:circle][:top_image_id].to_i == @circle.top_image.id
          @circle.top_image.purge
        end

        if params[:circle][:other_image_ids]
          params[:circle][:other_image_ids].each do |other_image_id|
            other_image = @circle.other_images.find(other_image_id)
            other_image.purge
          end
        end

        if @circle.update(circle_params)
          redirect_to circle_path
        else
          render :edit
        end
      end
    else
      redirect_to circle_path(@circle)
    end
  end

  def show
    @circle = Circle.find(params[:id])
  end

  def destroy
    circle =Circle.find(params[:id])
    redirect_to circle_path(circle) if current_user.circle_admin?(circle)
    circle.destroy!
    redirect_to root_path, notice: 'サークルを削除しました'
  end

  def circle_member
    @circle = Circle.find(params[:id])
    if current_user.circle_member?(@circle)
      @affiliations = @circle.affiliations.includes(:user).order(created_at: :desc)
    else
      flash.now[:alert] = 'サークルメンバーだけが閲覧できます'
    end
  end

  private

  def circle_params
    params.require(:circle).permit(:name, :introduction, :state, :top_image, { other_images: [] })
  end
end
