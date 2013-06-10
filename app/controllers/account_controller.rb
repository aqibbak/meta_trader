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
    new_acc = params[:new_account]
    if new_acc=="true"
      method = :new
    else
      method = :update
      data[:login] = key
    end
    api = ApiMethods.new

    @result = api.modifyAccount(data,session,method)
    render :nothing => true
  end

  def fetch_account
    authorize! :read, :account
    login = params[:login]
    api = ApiMethods.new
    #filter = { "login" => {"condition" => "=", "value" => login } }
    @account = api.getAccountFromLogin(session, login)
    @group = api.getGroup(session)
    @act = @account.first

  end

  def new_account
    authorize! :create, :account
    api = ApiMethods.new
    @act = {}
    @group = api.getGroup(session)
    render "fetch_account"
  end

end
