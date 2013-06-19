class ApiAccessController < ApplicationController
  include ApplicationHelper
  layout :resolve_layout

  def dashboard
    @hide_sidebar = true
  end

  def server_select
    api = ApiMethods.new
    server = Server.find(params[:server_id])
    login = ENV["MT_API_LOGIN"]
    password = ENV["MT_API_PASS"]
    result = api.login(session, server.server_address, login, password)
    puts result
    if result
      redirect_to main_page_path
    else
      flash[:error] = "Unable to log in."
      render "dashboard"
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
    @sym = api.symbolWithEmptySessions
    @backup = api.getBackup(session)
    @group = api.getGroup(session)
    @grp = {}
    @manager = api.getManager(session)
    @mgr = { "secgroups"=> {} }
    @feeder = api.getFeeder(session)
    @fdr = {}
    @synchronization = api.getSynchronization(session)
    @sync = {}
    @plugin = api.getPlugin(session)
    @plg = {"plugin" => {}, "params" => []}
    @account = api.getAccount(session)
    @act = {}
    @order = api.getOrder(session)
    @ord = { "conv_rates" => [] }
  end

  def ping_session
    api = ApiMethods.new
    api.ping(session)
    render :nothing => true
  end

  private

    def resolve_layout
      case action_name
      when "login_form"
        "login/application"
      else
        "application"
      end
    end
end