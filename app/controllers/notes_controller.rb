class NotesController < ApplicationController
  include Utils
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

  def destroy
    note = Note.find(params['id'])
    note.taggings.each do |tag|
      tag.delete
    end
    note.delete
    render nothing: true
  end

  def data
    respond_to do |format|
      format.js
    end
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

  def setup_tags
    @all_tags = @user_info.owned_tags.sort_by {|t| t.name }
    @all_tags_names = @all_tags.map{ |t| t.name }
  end

end
