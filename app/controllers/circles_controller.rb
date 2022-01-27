class CirclesController < ApplicationController
  def index; end

  def new
    @circle = Circle.new
  end

  def create
    @circle = current_user.circles.new(circle_params)
    # binding.pry
    if @circle.save
      Circle.new(circle_params)
      current_user.circlejoin(@circle)
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update; end

  def destroy; end

  private

  def circle_params
    params.require(:circle).permit(:name, :introduction, :top_image, { other_images: [] })
  end

end
