class NotesController < ApplicationController
  before_action :logged_in_using_omniauth?, :get_user_info
  skip_before_filter  :verify_authenticity_token
  before_filter :set_cache_headers
  before_action :get_notes, :setup_dates, :setup_tags

  def create
    @note = Note.new(note_params)
    tag_params = params['tag_list'].downcase
    if tag_params != "null"
      @user_info.tag(@note, :with => tag_params, :on => :tags)
    end
    if @note.save
      flash[:notice] = "Mem saved"
    else
      flash[:notice] = "Something went wrong"
    end
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
    render nothing: true
  end

  def destroy
    note = Note.find(params['id'])
    note.taggings.each do |tag|
      tag.delete
    end
    note.delete
    render nothing: true
  end

  def push_back
    note = Note.find(params["id"])
    note.update_attributes(:date_show => note.date_show + 1)
    render nothing: true
  end

  def push_back_more
    note = Note.find(params["id"])
    note.update_attributes(:date_show => note.date_show + 3)
    render nothing: true
  end

  private

  def note_params
    params.permit(:priority,
                  :date_show,
                  :body)
      .merge(:date_seen => date_today)
      .merge(:user => current_user)
  end

  def show_mems?
    @user_info.seen_mem_time <= (DateTime.now - 1.hour)
  end

  def show_dates?
    !(@user_info.dates_dismissed == Date.today)
  end

  def get_notes
    show_mems? ? @notes = Note.get_priority_notes(current_user) : @notes = []
    show_dates? ? @dates = Note.get_date_notes(current_user) : @dates = []
    setup_events if @dates != []
  end

  def get_user_info
    @user_info = UserInfo.where(:user_id => current_user).first
  end

  def setup_tags
    @all_tags = @user_info.owned_tags.sort_by {|t| t.name }
    @all_tags_names = @all_tags.map{ |t| t.name }
  end

  def current_user
    session[:userinfo]['extra']['raw_info']['identities'][0]['user_id']
  end

  def date_today
    Date.today
  end

  def setup_events
    @tomorrow_dates = @dates.where(:date_show => Date.tomorrow)
    @today_dates = @dates.where(:date_show => Date.today)
    @late_dates = @dates.where("date_show < ?", Date.today).sort_by{ |d| d.date_show }
  end

  def setup_dates
    @today = Date.today
    @tomorrow = Date.today + 1
    @three_days = Date.today + 3
    @week = Date.today + 7
    @two_weeks = Date.today + 14
    @month = Date.today + 30
  end

  def logged_in_using_omniauth?
    unless session[:userinfo].present?
      redirect_to '/auth0'
    end
  end

  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
end
