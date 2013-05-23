class Users::SessionsController < Devise::SessionsController

  skip_before_filter :check_api_connection

  def create
    api = ApiMethods.new
    result = api.login(session, params[:user][:login], params[:user][:password])
    if result
      user = User.find_by_login(params[:user][:login])
      if user.nil?
        User.create!(login: params[:user][:login], password: params[:user][:password])
      end
      super
    else
      flash[:error] = "Unable to log in"
      render "new"
    end
  end

end
