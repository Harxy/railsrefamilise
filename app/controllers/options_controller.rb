class OptionsController < ApplicationController
  include Utils
  before_action :logged_in_using_omniauth?, :get_user_info
  skip_before_filter  :verify_authenticity_token
  
  def edit
    @user_info.update_attributes(:mem_no => params["option_mem_no"])
    flash[:notice] = "Options saved"
    redirect_to '/notes'
  end

end
