class FeedbackController < ApplicationController
  include Utils
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

  def feedback_user
    "112755036556335586188"
  end

end
