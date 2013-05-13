class SymbolController < ApplicationController
  include ApplicationHelper

  def symbol_group_submit
    data = params[:symbol_group_tab]
    api = ApiMethods.new
    begin
      data.each do |d|
        if d[1]["changed"] == "true"
          d[1].delete("changed")
          api.updateSymbolGroup(d[1],session)
        end
      end
      render :nothing => true
    rescue => e
      @error = "An error occured while executing this operation"
      render "shared/error"
    end
  end

  def symbol_submit
    data = params[:symbol]
    key = params[:symbol_key]
    api = ApiMethods.new
    @result = api.updateSymbol(key,data,session)
    render :nothing => true
  end

  def fetch_symbol
    pos = params[:pos]
    api = ApiMethods.new
    @symbol_group = api.getSymbolGroup(session)
    @symbol = api.getSymbol(session)
    @sym = @symbol[pos.to_i]
  end

end