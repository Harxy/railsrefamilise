class NotesController < ApplicationController
  before_action :logged_in_using_omniauth?
  skip_before_filter  :verify_authenticity_token
  before_action :get_notes, :setup_dates

  def create
    @note = Note.new(note_params)
    @note.save
    redirect_to '/notes'
  end

  def seen
    note = Note.find(params["id"])
    note.update_attributes(:date_seen => date_today)
  end

  def delete_from_view
    note = Note.find(params["id"])
    note.update_attributes(:date_show => nil,
                           :priority => 0)
  end

  private

  def note_params
    params.permit(:title,
                  :priority,
                  :date_show,
                  :body)
      .merge(:date_seen => date_today)
      .merge(:user => current_user)
  end

  def get_notes
    @notes = Note.ready_to_show(current_user)
  end

  def current_user
    session[:userinfo]['uid']
  end

  def date_today
    Date.today
  end

  def setup_dates
    @today = Date.today
    @tomorrow = Date.today + 1
    @week = Date.today + 7
    @two_weeks = Date.today + 14
    @month = Date.today + 30
  end

  def logged_in_using_omniauth?
    unless session[:userinfo].present?
      redirect_to '/auth0'
    end
  end
end
