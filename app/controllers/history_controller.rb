class HistoryController < ApplicationController
  before_action :logged_in_using_omniauth?
  skip_before_filter  :verify_authenticity_token
  before_action :get_notes, :get_user_info, :get_tags

  private

  def get_tags
    @all_notes = Note.where(:user => current_user)
    @all_tags = @user_info.owned_tags.sort_by {|t| t.name }
    @hash = Hash.new { |h,k| h[k] = [] }
    @all_tags.each do |tag|
      @hash[tag] << @all_notes.tagged_with(tag)
    end
  end

  def get_notes
    Note.where(user: current_user)
  end

  def get_user_info
    @user_info = UserInfo.where(:user_id => current_user).first
  end

  def current_user
    session[:userinfo]['extra']['raw_info']['identities'][0]['user_id']
  end

  def logged_in_using_omniauth?
    unless session[:userinfo].present?
      redirect_to '/auth0'
    end
  end
end
