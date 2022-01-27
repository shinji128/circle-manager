class ApplicationController < ActionController::Base
  before_action :require_login

  def not_authenticated
    flash[:warning] = t('defaults.message.require_login')
    redirect_to auth_at_provider_path(:provider => :line)
  end
end
