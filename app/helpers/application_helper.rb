module ApplicationHelper

  def options_for_ip_address(all_addresses,selected=nil)
    selected_in = false
    options = ""
    all_addresses.each do |address|
      if address != 0
        options += "<option value='#{address}'#{' selected=true' if selected==address}>#{ApiMethods.long2ip(address)}</option>"
      end
      selected_in = true if selected == address
    end
    unless selected_in
      options += "<option value='#{selected}' selected=true>#{selected}</option>"
    end
    options = "<option value='0'#{' selected=true' if selected==0}>any address</option>" + options
    return options.html_safe
  end

  def options_for_demo_type(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>No</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Prolong from last login</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>With fixed period</option>"
    return options.html_safe
  end

  def options_for_timezone(selected=nil)
    options = ""
    (-12..12).to_a.each do |hour|
      value = "#{hour >= 0 ? '+' : '-'}" + hour.abs.to_s.rjust(2, '0') + ":00"
      options += "<option value='#{hour.to_s}'#{' selected=true' if selected==hour}>GMT#{value}</option>"
    end
    return options.html_safe
  end

  def options_for_yes_no(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>No</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Yes</option>"
    return options.html_safe
  end

  def options_for_rollover(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Normal</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Reopen by close price</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Reopen by bid</option>"
    return options.html_safe
  end

  def options_for_statements(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>End of the day</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Start of the day</option>"
    return options.html_safe
  end

  def options_for_monthly_statements(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>First day of month</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Last day of month</option>"
    return options.html_safe
  end

  def time_hours(time_in_minutes)
    (time_in_minutes/60).to_i
  end

  def time_minutes(time_in_minutes)
    time_in_minutes - time_hours(time_in_minutes)*60
  end

  def options_for_live_update(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Disabled</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>All components</option>"
    return options.html_safe
  end

  def options_for_timesync(selected=nil)
    options = ""
    options += "<option value='ntp0.coreng.com.au'#{' selected=true' if selected=='ntp0.coreng.com.au'}>ntp0.coreng.com.au</option>"
    options += "<option value='ntp0.cs.mu.OZ.AU'#{' selected=true' if selected=='ntp0.cs.mu.OZ.AU'}>ntp0.cs.mu.OZ.AU</option>"
    options += "<option value='ntp1.cs.mu.OZ.AU'#{' selected=true' if selected=='ntp1.cs.mu.OZ.AU'}>ntp1.cs.mu.OZ.AU</option>"
    options += "<option value='ntp1.rnp.br'#{' selected=true' if selected=='ntp1.rnp.br'}>ntp1.rnp.br</option>"
    options += "<option value='ntps1.pads.ufrj.br'#{' selected=true' if selected=='ntps1.pads.ufrj.br'}>ntps1.pads.ufrj.br</option>"
    options += "<option value='clock.uregina.ca'#{' selected=true' if selected=='clock.uregina.ca'}>clock.uregina.ca</option>"
    options += "<option value='tick.usask.ca'#{' selected=true' if selected=='tick.usask.ca'}>tick.usask.ca</option>"
    options += "<option value='tock.usask.ca'#{' selected=true' if selected=='tock.usask.ca'}>tock.usask.ca</option>"
    options += "<option value='ntp.metas.ch'#{' selected=true' if selected=='ntp.metas.ch'}>ntp.metas.ch</option>"
    options += "<option value='swisstime.ethz.ch'#{' selected=true' if selected=='swisstime.ethz.ch'}>swisstime.ethz.ch</option>"
    options += "<option value='ntp.dgf.uchile.cl'#{' selected=true' if selected=='ntp.dgf.uchile.cl'}>ntp.dgf.uchile.cl</option>"
    options += "<option value='ntp.shoa.cl'#{' selected=true' if selected=='ntp.shoa.cl'}>ntp.shoa.cl</option>"
    options += "<option value='clock.psu.edu'#{' selected=true' if selected=='clock.psu.edu'}>clock.psu.edu</option>"
    return options.html_safe
  end

  def options_for_adapters(adapter_list)
    options = ""
    adapter_list.each_with_index do |adapter, ix|
      options += "<option value='#{ix}'>#{adapter}</option>"
    end
    return options.html_safe
  end

  def options_for_access_action(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>block</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>permit</option>"
    return options.html_safe
  end

  def options_for_data_server_priority(selected=nil)
    options = ""
    (0..15).to_a.each do |priority|
      options += "<option value='#{priority}'#{' selected=true' if selected==priority}>#{priority}</option>"
    end
    options += "<option value='255'#{' selected=true' if selected==255}>Idle</option>"
    return options.html_safe
  end

  def day_of_week(day)
    return case day
      when 0
        "Sunday"
      when 1
        "Monday"
      when 2
        "Tuesday"
      when 3
        "Wednesday"
      when 4
        "Thursday"
      when 5
        "Friday"
      when 6
        "Sunday"
      end
  end

  def options_for_holiday_securities(securities_data,selected=nil)
    options = "<option value='All'#{' selected=true' if selected=='All'}>All</option>"
    securities_data.each do |security|
      if security["name"] != ""
        options += "<option value='#{security["name"]}'#{' selected=true' if selected==security["name"]}>#{security["name"]}</option>"
      end
    end
    return options.html_safe
  end

  def get_symbol_group_symbols(index, symbols)
    group_array = []
    symbols.each do |s|
      if s["type"] == index
        group_array << s
      end
    end
    if group_array.count > 0
      list = "#{group_array.count}: "
      group_array.each_with_index do |s, ix|
        list += "," unless ix==0
        list += s["symbol"]
      end
      return list
    else
      return ""
    end
  end

  def options_for_watch_role(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Stand alone</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Master</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Slave</option>"
    return options.html_safe
  end

  def options_for_backup_period(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>1 hour</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>4 hours</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>1 day</option>"
    return options.html_safe
  end

  def options_for_arch_backup_period(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Disabled</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>5 minutes</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>15 minutes</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>30 minutes</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>1 hour</option>"
    return options.html_safe
  end

  def options_for_archive_store(selected=nil)
        options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>1 day</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>3 days</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>1 week</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>2 weeks</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>1 month</option>"
    options += "<option value='5'#{' selected=true' if selected==5}>3 months</option>"
    options += "<option value='6'#{' selected=true' if selected==6}>6 months</option>"
    return options.html_safe
  end

  def options_for_export_period(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>1 minute</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>5 minutes</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>15 minutes</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>30 minutes</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>1 hour</option>"
    return options.html_safe
  end

end
