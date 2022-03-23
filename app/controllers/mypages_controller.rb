class MypagesController < ApplicationController

  def show
    @circles = current_user.affiliation_circles
  end

  def edit
    @user = User.find(current_user.id)
  end

  def update
    @user = User.find(current_user.id)
    ActiveRecord::Base.transaction do
      if params[:user][:avatar_id].to_i == @user.avatar.id
        @user.avatar.purge
      end
      if @user.update(user_params)
        redirect_to mypage_path(@user), notice: 'マイページを編集しました'
      else
        flash.now[:alert] = 'マイページを編集できませんでした'
        render :edit
      end
    end
  end

  def user_params
    params.require(:user).permit(:name, :avatar)
  end
end
