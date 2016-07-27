class FeedbackController < ApplicationController
  before_action :logged_in_using_omniauth?, :get_user_info
  skip_before_action :verify_authenticity_token

  def create
    note = Note.new(note_params)
    @user_info.tag(note, :with => "feedback", :on => :tags)
    if note.save
      flash[:notice] = "Feedback saved"
    else
      flash[:notice] = "Something went wrong"
    end
    redirect_to '/notes'
  end

  private

  def note_params
    params.permit(:body)
      .merge(:priority => 3)
      .merge(:date_seen => Date.yesterday)
      .merge(:user => feedback_user)
  end
  def logged_in_using_omniauth?
    unless session[:userinfo].present?
      redirect_to '/auth0'
    end
  end

  def feedback_user
    "112755036556335586188"
  end

  def get_user_info
    @user_info = UserInfo.where(:user_id => feedback_user).first
  end

  def current_user
    session[:userinfo]['extra']['raw_info']['identities'][0]['user_id']
  end
end
