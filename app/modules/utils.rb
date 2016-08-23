module Utils

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

  def date_today
    Date.today
  end

  def current_user
    session[:userinfo]['extra']['raw_info']['identities'][0]['user_id']
  end

  def get_notes
    show_mems? ? @notes ||= Note.get_priority_notes(current_user, @user_info.mem_no) : @notes = []
    show_dates? ? @dates = Note.get_date_notes(current_user) : @dates = []
    setup_events if @dates != []
  end

  def setup_events
    @tomorrow_dates = @dates.where(:date_show => Date.tomorrow)
    @today_dates = @dates.where(:date_show => Date.today)
    @late_dates = @dates.where("date_show < ?", Date.today).sort_by{ |d| d.date_show }.reverse
  end


  def get_user_info
    @user_info = UserInfo.where(:user_id => current_user).first
  end

  def show_mems?
    @user_info.seen_mem_time <= (DateTime.now - 1.hour)
  end

  def show_dates?
    !(@user_info.dates_dismissed == Date.today)
  end


end
