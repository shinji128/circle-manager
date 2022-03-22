class MypagesController < ApplicationController

  def show
    @circles = current_user.affiliation_circles
  end
end
