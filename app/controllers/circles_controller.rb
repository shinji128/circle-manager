class CirclesController < ApplicationController
  def index
    @circles = Circle.with_attached_top_image.order(created_at: :desc)
  end

  def new
    @circle = Circle.new
  end

  def create
    @circle = current_user.circles.new(circle_params)
    if @circle.save
      Affiliation.create(user: current_user, circle: @circle)
      redirect_to root_path
    end
  end

  def edit
    @circle = Circle.find(params[:id])
    redirect_to circle_path(@circle) if !@circle.circle_member?(current_user)
  end

  def update
    @circle = Circle.find(params[:id])
    redirect_to circle_path(@circle) if !@circle.circle_member?(current_user)
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
  end

  def show
    @circle = Circle.find(params[:id])
  end

  def circle_member
    @circle = Circle.find(params[:id])
    if @circle.affiliation_user.include?(current_user)
      @affiations = @circle.affiliations.includes(:user).order(created_at: :desc)
    else
      flash.now[:notice] = 'サークルメンバーだけが閲覧できます'
    end
  end

  private

  def circle_params
    params.require(:circle).permit(:name, :introduction, :top_image, { other_images: [] })
  end
end
