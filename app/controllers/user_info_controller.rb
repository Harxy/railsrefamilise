class UserInfoController < ApplicationController
  before_action :logged_in_using_omniauth?, :get_user_info

  def seen_it
    @user_info.update_attributes(:seen_mem_time => DateTime.now)
    render nothing: true
  end

  private
  # all three of these below should be their own helper methods
  def current_user
    session[:userinfo]['extra']['raw_info']['identities'][0]['user_id']
  end

  def get_user_info
    @user_info = UserInfo.where(:user_id => current_user).first
  end

  def logged_in_using_omniauth?
    unless session[:userinfo].present?
      redirect_to '/auth0'
    end
  end
end
