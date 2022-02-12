class CircleRolesController < ApplicationController
  def new
    @circle = Circle.find(params[:circle_id])
    @circle_role = CircleRole.new
  end

  def create
    @circle = Circle.find(params[:circle_id])
    role_params = params[:circle_role][:circle_role_attributes]
    role_params.each do |role|
      @circle.circle_roles.create!(name: role['name'])
    end
    redirect_to root_path
  end
end
