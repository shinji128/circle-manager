class MypagesController < ApplicationController
  before_action :set_user

  def show
    @circles = @user.affiliation_circles
  end

  private

  def set_user
    @user = User.find(current_user.id)
  end
end
