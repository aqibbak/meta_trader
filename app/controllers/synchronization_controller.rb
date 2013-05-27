class SynchronizationController < ApplicationController
  include ApplicationHelper

  def synchronization_submit
    authorize! :update, :synchronization
    data = params[:synchronization]
    key = params[:sync_key]
    api = ApiMethods.new
    @result = api.updateSynchronization(key,data,session)
    render :nothing => true
  end

  def fetch_synchronization
    authorize! :read, :synchronization
    pos = params[:pos]
    api = ApiMethods.new
    @synchronization = api.getSynchronization(session)

    @sync = @synchronization[pos.to_i]

  end

end