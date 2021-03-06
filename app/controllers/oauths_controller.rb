class OauthsController < ApplicationController
  skip_before_action :require_login

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_back_or_to root_path, notice: 'LINEでログインしました'
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule

        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_back_or_to root_path, notice: 'ログインしました'
      rescue StandardError
        redirect_back_or_to root_path, alert: 'ログインに失敗しました'
      end
    end
  end

  def guest_login
    guest_user = User.find(2)
    auto_login(guest_user)
    redirect_to root_path, notice: 'ゲストとしてログインしました'
  end

  def destroy
    logout
    redirect_to root_path, notice: 'ログアウトしました'
  end

  # example for Rails 4: add private method below and use "auth_params[:provider]" in place of
  # "params[:provider] above.

  # private
  # def auth_params
  #   params.permit(:code, :provider)
  # end
end
