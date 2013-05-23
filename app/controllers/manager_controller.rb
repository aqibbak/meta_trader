class ManagerController < ApplicationController
  include ApplicationHelper

  def manager_submit
    authorize! :update, :manager
    data = params[:manager]
    key = params[:manager_key]
    api = ApiMethods.new
    @result = api.updateManager(key,data,session)
    render :nothing => true
  end

  def fetch_manager
    authorize! :read, :manager
    pos = params[:pos]
    api = ApiMethods.new
    @manager = api.getManager(session)
    @symbol_group = api.getSymbolGroup(session)

    @mgr = @manager[pos.to_i]

  end

end