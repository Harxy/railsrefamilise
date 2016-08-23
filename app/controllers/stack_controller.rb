class StackController < ApplicationController
  include Utils
  before_action :logged_in_using_omniauth?, :get_user_info
  skip_before_filter :verify_authenticity_token
  before_action :get_notes
  
  def change_priority
    increase = params["direction"] == 'up'
    note = Note.find(params["id"])
    note.update_attributes(:date_seen => date_today)
    if increase
      if note.priority < 5
        note.update_attributes(:priority => note.priority + 1,
                               :date_seen => date_today)
      end
    else
      if note.priority > 1
        note.update_attributes(:priority => note.priority - 1,
                               :date_seen => date_today)
      end
    end
    render nothing: true
  end

  def data_output
    respond_to do |format|
      format.html
      format.js
    end
  end

  def destroy
    note = Note.find(params['id'])
    note.taggings.each do |tag|
      tag.delete
    end
    note.delete
    render nothing: true
  end
end
