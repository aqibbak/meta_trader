class PluginController < ApplicationController
  include ApplicationHelper

  def plugin_submit
    authorize! :update, :plugin
    data = params[:plugin]
    key = params[:plugin_key]
    api = ApiMethods.new
    @result = api.updatePlugin(key,data,session)
    @plg = {}
  end

  def new_plugin
    authorize! :create, :plugin
    api = ApiMethods.new
    @plg = {}
    render "fetch_plugin"
  end

  def fetch_plugin
    authorize! :read, :plugin
    pos = params[:pos]
    api = ApiMethods.new
    @plugin = api.getPlugin(session)
    @plg = @plugin[pos.to_i]
  end

end