class AccountController < ApplicationController
  include ApplicationHelper

  def filter_account
    authorize! :read, :account
    filter = params[:account_filter]
    api = ApiMethods.new
    @account = api.getAccount(session,filter)
  end

  def account_submit
    authorize! :update, :account
    data = params[:account]
    key = params[:account_key]
    api = ApiMethods.new
    #@result = api.updateAccount(key,data,session)
    render :nothing => true
  end

  def fetch_account
    authorize! :read, :account
    login = params[:login]
    api = ApiMethods.new
    filter = { "login" => {"condition" => "=", "value" => login } }
    @account = api.getAccount(session, filter)

    @act = @account.first

  end

end
