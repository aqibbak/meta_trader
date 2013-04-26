class FixedUpdateController < ApplicationController
  include ApplicationHelper

  def common_submit
    data = params[:common_tab]
    api = ApiMethods.new
    result = api.updateCommon(data,session)
    render :nothing => true
  end

  def time_submit
    data = params[:time_tab].map { |k,v| v.to_i }
    api = ApiMethods.new
    result = api.updateTime(data,session)
    render :nothing => true
  end

  def backup_submit
    data = params[:backup_tab]
    api = ApiMethods.new
    result = api.updateBackup(data,session)
    render :nothing => true
  end

end