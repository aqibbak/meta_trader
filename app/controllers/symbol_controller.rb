class SymbolController < ApplicationController
  include ApplicationHelper

  def symbol_group_submit
    authorize! :update, :symbol_group
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
    authorize! :update, :symbol
    data = params[:symbol]
    new_sym = params[:new_symbol]
    if new_sym
      key = params[:symbol][:symbol]
    else
      key = params[:symbol_key]
    end
    api = ApiMethods.new
    @result = api.updateSymbol(key,data,session)
    @symbol_group = api.getSymbolGroup(session)
    @symbol = api.getSymbol(session)
    @sym = api.symbolWithEmptySessions
  end

  def new_symbol
    authorize! :create, :symbol
    api = ApiMethods.new
    @sym = api.symbolWithEmptySessions
    @symbol = api.getSymbol(session)
    @symbol_group = api.getSymbolGroup(session)
    render "fetch_symbol"
  end

  def fetch_symbol
    authorize! :read, :symbol
    pos = params[:pos]
    api = ApiMethods.new
    @symbol_group = api.getSymbolGroup(session)
    @symbol = api.getSymbol(session)
    @sym = @symbol[pos.to_i]
  end

end