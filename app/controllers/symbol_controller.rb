class SymbolController < ApplicationController
  include ApplicationHelper

  def symbol_group_submit
    data = params[:symbol_group_tab]
    api = ApiMethods.new
    data.each do |d|
      if d[1]["changed"] == "true"
        d[1].delete("changed")
        api.updateSymbolGroup(d[1],session)
      end
    end
    render :nothing => true
  end

end