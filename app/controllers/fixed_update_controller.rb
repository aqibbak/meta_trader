class FixedUpdateController < ApplicationController
  include ApplicationHelper

  def common_submit
    data = params[:common_tab]
    api = ApiMethods.new
    begin
      result = api.updateCommon(data,session)
      if result[:success]
        render :nothing => true
      else
        @error = result[:msg]
        render "shared/error"  
      end
    rescue => e
      @error = "An error occured while executing this operation"
      render "shared/error"
    end
  end

  def time_submit
    data = params[:time_tab].map { |k,v| v.to_i }
    api = ApiMethods.new
    begin
      result = api.updateTime(data,session)
      if result[:success]
        render :nothing => true
      else
        @error = result[:msg]
        render "shared/error"  
      end
    rescue => e
      @error = "An error occured while executing this operation"
      render "shared/error"
    end
  end

  def backup_submit
    data = params[:backup_tab]
    api = ApiMethods.new
    begin
      result = api.updateBackup(data,session)
      if result[:success]
        render :nothing => true
      else
        @error = result[:msg]
        render "shared/error"  
      end
    rescue => e
      @error = "An error occured while executing this operation"
      render "shared/error"
    end
  end

end