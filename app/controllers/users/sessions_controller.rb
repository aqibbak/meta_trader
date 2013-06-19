class Users::SessionsController < Devise::SessionsController

  skip_before_filter :check_api_connection

  layout "login/application"

  def create
    super
  end

end
