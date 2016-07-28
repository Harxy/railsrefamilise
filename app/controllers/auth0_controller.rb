class Auth0Controller < ApplicationController
  def callback
    session[:userinfo] = request.env['omniauth.auth']
    if empty_database?
      add_welcome_mems
      add_user_info
    end
    redirect_to '/notes'
  end

  def failure
    @error_msg = request.params['message']
  end

  def add_user_info
    @user_info = UserInfo.create(:user_id => current_user,
                                 :new_user => false,
                                 :seen_mems => false,
                                 :seen_mem_time => (DateTime.now - 2.hour))
  end

  def logout
    session[:userinfo] = nil
    redirect_to "https://memtank.eu.auth0.com/v2/logout?returnTo=https://memtank.herokuapp.com"
  end

  def empty_database?
    !UserInfo.where(user_id: current_user).exists?
  end

  def add_welcome_mems
    date_time = Date.yesterday
    note2 = Note.new(:tag_list => ["welcome"],
                     :body => "Welcome to MemTank, a little web app designed to help you remember things. You can read a blog post all about it here: \n\n https://memtank.herokuapp.com/blog#blog1 \n\n This thing you are reading now is an example mem to help you get going.\n\n Click the green Seen it! tick above to continue.",
                     :priority => 3,
                     :date_seen => date_time,
                     :user => current_user)
    note1 = Note.new(:tag_list => ["welcome"],
                     :body => "The Seen it! button sends the note back into the MemTank. It'll be back, depending on its priority, but not today. You can also delete a note, using the red trash icon, or tell MemTank you want to see it again soon, even today, using the blue repeat symbol.",
                     :priority => 3,
                     :date_seen => date_time,
                     :user => current_user)
    note4 = Note.new(:tag_list => ["welcome"],
                     :body => "There are two basic types of mem. There are mems, and alerts. \n\n An alert is just a mem that has a specific date attached to it, and will pop up on that day. Normally mems are just selected from the stack to display to you. \n\n I won't bore you with exactly how it works, but a High priority mem will be reshown to you roughly three times as often as a low priority mem.",
                     :priority => 2,
                     :date_seen => date_time,
                     :user => current_user)
    note3 = Note.new(:tag_list => ["welcome"],
                     :body => "If you choose to save a mem by date (tomorrow, next week, etc), the mem won't reappear until exactly that date. These are called alerts. Why not make a mem now and tell it to pop up again tomorrow? You don't have to tag it with anything if you don't want to. \n\n Click the green tick once you're done.",
                     :priority => 2,
                     :date_seen => date_time,
                     :user => current_user)
    note5 = Note.new(:tag_list => ["welcome"],
                     :body => "That's basically it for the functionality for now, but see the blog for updates, and 101 different ways I use MemTank. Thanks, and I hope you enjoy it!",
                     :priority => 1,
                     :date_seen => date_time,
                     :user => current_user)
    note1.save
    note2.save
    note3.save
    note4.save
    note5.save
  end

  def current_user
    session[:userinfo]['extra']['raw_info']['identities'][0]['user_id']
  end
end
