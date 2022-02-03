class CirclesController < ApplicationController
  skip_before_action :require_login, only: %i[index show]
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

  def show
    @circle = Circle.find(params[:id])
    @image_count = @circle.other_images.count
  end

  private

  def circle_params
    params.require(:circle).permit(:name, :introduction, :top_image, { other_images: [] })
  end
end
