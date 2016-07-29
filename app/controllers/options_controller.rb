class OptionsController < ApplicationController
  before_action :logged_in_using_omniauth?, :get_user_info
  
  private

  def logged_in_using_omniauth?
    unless session[:userinfo].present?
      redirect_to '/auth0'
    end
  end

  def get_user_info
    @user_info = UserInfo.where(:user_id => current_user).first
  end

  def current_user
    session[:userinfo]['extra']['raw_info']['identities'][0]['user_id']
  end
end
