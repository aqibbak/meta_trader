class OrderController < ApplicationController
  include ApplicationHelper

  def filter_order
    authorize! :read, :order
    filter = params[:order_filter]
    api = ApiMethods.new
    @account = api.getOrder(session,filter)
  end

  def order_submit
    authorize! :update, :order
    data = params[:order]
    api = ApiMethods.new
    @result = api.updateOrder(data,session) unless data.nil?
    render :nothing => true
  end

  def fetch_order
    authorize! :read, :order
    order = params[:order]
    api = ApiMethods.new
    filter = { "ticket" => {"condition" => "=", "value" => order }}
    @order = api.getOrder(session)
    @symbol = api.getSymbol(session)

    @ord = @order[order.to_i]
  end

end
