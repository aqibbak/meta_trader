class SynchronizationController < ApplicationController
  include ApplicationHelper

  def synchronization_submit
    authorize! :update, :synchronization
    data = params[:synchronization]
    position = params[:position]
    api = ApiMethods.new
    @result = api.updateSynchronization(position,data,session)
    render :nothing => true
  end

  def fetch_synchronization
    authorize! :read, :synchronization
    @pos = params[:pos]
    api = ApiMethods.new
    @synchronization = api.getSynchronization(session)

    @sync = @synchronization[@pos.to_i]

  end

end