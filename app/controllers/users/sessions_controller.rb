class Users::SessionsController < Devise::SessionsController

  skip_before_filter :check_api_connection

  layout "login/application"

  def create
    api = ApiMethods.new
    server = Server.find(params[:user][:server_id])
    result = api.login(session, server.server_address, params[:user][:login], params[:user][:password])
    puts result
    if result
      user = User.find_by_login_and_server_id(params[:user][:login],params[:user][:server_id])
      if user.nil?
        User.create!(server_id: params[:user][:server_id], login: params[:user][:login], password: params[:user][:password])
      end
      super
    else
      flash[:error] = "Unable to log in"
      render "new"
    end
  end

end
