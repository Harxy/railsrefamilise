class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']
    if empty_database?
      add_welcome_mems
    end
    redirect_to '/notes'
  end

  def failure
    @error_msg = request.params['message']
  end

  def logout
    session[:userinfo] = nil
    redirect_to "https://memtank.eu.auth0.com/v2/logout?federated?returnTo=http://memtank.herokuapp.com"
  end

  def empty_database?
    Note.where(user: session[:userinfo]['uid']).length == 0
  end

  def add_welcome_mems
    date_time = Date.yesterday
    note2 = Note.new(:title => "Welcome",
                     :body => "Welcome to MemTank. This is an example note to help you get going. Click Seen it! below to continue.",
                     :priority => 3,
                     :date_seen => date_time,
                     :user => session[:userinfo]['uid'])
    note1 = Note.new(:title => "Welcome",
                     :body => "The Seen it! button sends the note back into the MemTank. It'll be back, depending on its priority, but not today. You can also delete a note or say that you want to see it again soon.",
                     :priority => 3,
                     :date_seen => date_time,
                     :user => session[:userinfo]['uid'])
    note4 = Note.new(:title => "Welcome",
                     :body => "When creating your own notes, you can either prioritize them, based on how soon you want to see them again, or by time period until you want to see them again (Tomorrow, Next Week.. etc). I won't bore you with exactly how it works, but a High priority mem will be reshown to you roughly three times as often as a low priority mem.",
                     :priority => 2,
                     :date_seen => date_time,
                     :user => session[:userinfo]['uid'])
    note3 = Note.new(:title => "Welcome",
                     :body => "If you choose to do it by time period, the mem won't reappear until exactly that date. Why not make a mem now and tell it to pop up again in a week? I'll wait.",
                     :priority => 2,
                     :date_seen => date_time,
                     :user => session[:userinfo]['uid'])
    note5 = Note.new(:title => "Welcome",
                     :body => "That's basically it for the functionality for now, but see the blog for updates, and 101 different ways I use MemTank. Thanks, and I hope you enjoy it!",
                     :priority => 1,
                     :date_seen => date_time,
                     :user => session[:userinfo]['uid'])
    note1.save
    note2.save
    note3.save
    note4.save
    note5.save
  end
end
