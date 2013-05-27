class VariableUpdateController < ApplicationController
  include ApplicationHelper

  def access_submit
    authorize! :update, :access
    @data = params[:access_tab]
    @new = params[:access_new_record] == "true"
    api = ApiMethods.new
    begin
      @result = api.updateAccess(@data,session)
      @data["to"] = ApiMethods.ip2long(@data["to"])
      @data["from"] = ApiMethods.ip2long(@data["from"])
    rescue => e
      @error = true
    end
  end

  def access_delete
    authorize! :delete, :access
    @position = params[:position]
    api = ApiMethods.new
    @result = api.deleteAccess(@position,session)
  end

  def data_server_submit
    authorize! :update, :data_server
    data = params[:data_server_tab]
    @new = params[:data_server_new_record] == "true"
    api = ApiMethods.new
    begin
      @result = api.updateDataServer(data,session)
      position = data["position"]
      @data = api.getDataServer(session,position)
      @data["position"] = position
    rescue => e
      puts e
      @error = true
    end
  end

  def data_server_delete
    authorize! :delete, :data_server
    @position = params[:position]
    api = ApiMethods.new
    @result = api.deleteDataServer(@position,session)
  end

  def holiday_submit
    authorize! :update, :holiday
    @data = params[:holiday_tab]
    @new = params[:holiday_new_record] == "true"
    api = ApiMethods.new
    begin
      @result = api.updateHoliday(@data,session)
      @data["from"] = @data["from"]["hour"].to_i*60 + @data["from"]["minute"].to_i
      @data["to"] = @data["to"]["hour"].to_i*60 + @data["to"]["minute"].to_i
      puts @new
    rescue => e
      @error = true
    end
  end

  def holiday_delete
    authorize! :delete, :holiday
    @position = params[:position]
    api = ApiMethods.new
    @result = api.deleteHoliday(@position,session)
  end

end