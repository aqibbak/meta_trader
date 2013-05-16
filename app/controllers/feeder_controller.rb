class FeederController < ApplicationController
  include ApplicationHelper

  def feeder_submit
    data = params[:feeder]
    key = params[:feeder_key]
    api = ApiMethods.new
    @result = api.updateFeeder(key,data,session)
    render :nothing => true
  end

  def fetch_feeder
    pos = params[:pos]
    api = ApiMethods.new
    @feeder = api.getFeeder(session)

    @fdr = @feeder[pos.to_i]

  end

end