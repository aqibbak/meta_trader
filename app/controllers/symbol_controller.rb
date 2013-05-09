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

end