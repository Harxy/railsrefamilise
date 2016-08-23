class HistoryController < ApplicationController
  include Utils
  before_action :logged_in_using_omniauth?
  skip_before_filter  :verify_authenticity_token
  before_action :get_notes, :get_user_info, :get_tags

  private

  def get_tags
    @all_notes = Note.where(:user => current_user)
    @untagged = @all_notes.select { |n| n.tags == [] }
    @all_tags = @user_info.owned_tags.sort_by {|t| t.name }
    @hash = Hash.new { |h,k| h[k] = [] }
    @all_tags.each do |tag|
      @hash[tag] << @all_notes.tagged_with(tag)
    end
  end

  def get_notes
    Note.where(user: current_user)
  end

end
