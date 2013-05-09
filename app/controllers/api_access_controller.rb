class ApiAccessController < ApplicationController
  include ApplicationHelper

  def login_form
  end

  def login
    api = ApiMethods.new
    result = api.login(session, params[:username], params[:password])
    if result
      redirect_to main_page_path
    else
      flash[:error] = "Unable to log in"
      redirect_to root_path
    end
  end

  def main_page
    api = ApiMethods.new
    @common = api.getCommon(session)
    @access = api.getAccess(session)
    @data_server = api.getDataServer(session)
    @time = api.getTime(session)
    @holiday = api.getHoliday(session)
    @security = api.getSecurity(session)
    @symbol_group = api.getSymbolGroup(session)
    @symbol = api.getSymbol(session)
    #@backup = api.getBackup(session)
  end

  def ping_session
    api = ApiMethods.new
    api.ping(session)
    render :nothing => true
  end

end