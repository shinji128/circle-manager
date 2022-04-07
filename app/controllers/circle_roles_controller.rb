class CircleRolesController < ApplicationController
  before_action :set_circle, only: %i[new create destroy]

  def new
    @circle_role = CircleRole.new
    @circle_roles = @circle.circle_roles.includes(:circle)
  end

  def create
    role_params = params[:circle_role][:circle_role_attributes]
    role_params.each do |role|
      @circle.circle_roles.create!(name: role['name']) if !role['name'].blank?
    end
    redirect_to new_circle_circle_role_path(@circle)
  end

  def destroy
    circle_role = CircleRole.find(params[:id])
    circle_role.destroy!
    redirect_to new_circle_circle_role_path(@circle), notice: '役割を削除しました'
  end

private

  def set_circle
    @circle = Circle.find(params[:circle_id])
    redirect_to circle_path(@circle) if !@circle.circle_member?(current_user)
  end

end
