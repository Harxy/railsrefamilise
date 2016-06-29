class HistoryController < ApplicationController
  before_action :logged_in_using_omniauth?
  skip_before_filter  :verify_authenticity_token
  before_action :get_notes

  def get_notes
    Note.where(user: current_user)
  end

  def current_user
    session[:userinfo]['uid']
  end
end
