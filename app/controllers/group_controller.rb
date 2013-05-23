class GroupController < ApplicationController
  include ApplicationHelper

  def group_submit
    authorize! :update, :group
    data = params[:group]
    new_grp = params[:new_group]
    if new_grp
      key = params[:group][:group]
    else
      key = params[:group_key]
    end
    api = ApiMethods.new
    @result = api.updateGroup(key,data,session)
    @group = api.getGroup(session)

    @security = api.getSecurity(session)
    @grp = {}
  end

  def fetch_group
    authorize! :read, :group
    pos = params[:pos]
    api = ApiMethods.new
    @group = api.getGroup(session)
    @symbol_group = api.getSymbolGroup(session)
    @symbol = api.getSymbol(session)

    @grp = @group[pos.to_i]

  end

end