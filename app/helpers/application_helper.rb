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

  def options_for_source_select(symbols,selected=nil)
    options = "<option value=''></option>"
    symbols.each do |symbol|
      options += "<option value='#{symbol["symbol"]}'#{' selected=true' if selected==symbol["symbol"]}>#{symbol["symbol"]}</option>"
    end
    return options.html_safe
  end

  def options_for_symbol_digits(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>0</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>1</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>2</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>3</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>4</option>"
    options += "<option value='5'#{' selected=true' if selected==5}>5</option>"
    return options.html_safe
  end

  def options_for_symbol_type(symbol_groups,selected=nil)
    options = ""
    symbol_groups.each_with_index do |symbol_group, ix|
      options += "<option value='#{ix}'#{' selected=true' if selected==ix}>#{symbol_group["name"]}</option>" if symbol_group["name"] != ""
    end
    return options.html_safe
  end

  def options_for_symbol_execution(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Request</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Instant</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Market</option>"
    return options.html_safe
  end

  def options_for_symbol_currency(selected=nil)
    options = ""
    options += "<option value='USD'#{' selected=true' if selected=="USD"}>USD</option>"
    options += "<option value='EUR'#{' selected=true' if selected=="EUR"}>EUR</option>"
    options += "<option value='GBP'#{' selected=true' if selected=="GBP"}>GBP</option>"
    options += "<option value='JPY'#{' selected=true' if selected=="JPY"}>JPY</option>"
    options += "<option value='CHF'#{' selected=true' if selected=="CHF"}>CHF</option>"
    return options.html_safe
  end

  def options_for_symbol_trade(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>No</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Close only</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Full access</option>"
    return options.html_safe
  end

  def options_for_symbol_orders(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Good till today including SL/TP</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>Good till cancelled</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Good till today excluding SL/TP</option>"
    return options.html_safe
  end

  def options_for_spread_balance(symbol)
    spread = symbol["spread"]
    selected = symbol["spread_balance"]
    options = ""
    (-150..150).to_a.each do |ix|
      options += "<option value='#{ix}'#{' selected=true' if selected==ix}>#{ix-(spread.to_f/2).floor.to_i} bid/#{ix+(spread.to_f/2).ceil.to_i} ask</option>"
    end
    return options.html_safe
  end

  def options_for_symbol_filter_limit(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected=="0"}>no</option>"
    options += "<option value='0.001'#{' selected=true' if selected=="0.001"}>0.1</option>"
    options += "<option value='0.005'#{' selected=true' if selected=="0.005"}>0.5</option>"
    options += "<option value='0.01'#{' selected=true' if selected=="0.01"}>1.0</option>"
    options += "<option value='0.03'#{' selected=true' if selected=="0.03"}>3.0</option>"
    options += "<option value='0.05'#{' selected=true' if selected=="0.05"}>5.0</option>"
    options += "<option value='0.1'#{' selected=true' if selected=="0.1"}>10.0</option>"
    options += "<option value='0.15'#{' selected=true' if selected=="0.15"}>15.0</option>"
    options += "<option value='0.2'#{' selected=true' if selected=="0.2"}>20.0</option>"
    return options.html_safe
  end

  def options_for_symbol_filter_counter(selected=nil)
    options = ""
    options += "<option value='1'#{' selected=true' if selected==1}>1</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>2</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>3</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>4</option>"
    options += "<option value='5'#{' selected=true' if selected==5}>5</option>"
    options += "<option value='6'#{' selected=true' if selected==6}>6</option>"
    options += "<option value='7'#{' selected=true' if selected==7}>7</option>"
    options += "<option value='8'#{' selected=true' if selected==8}>8</option>"
    options += "<option value='9'#{' selected=true' if selected==9}>9</option>"
    options += "<option value='10'#{' selected=true' if selected==10}>10</option>"
    return options.html_safe
  end

  def options_for_symbol_filter_smoothing(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>off</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>2</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>3</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>4</option>"
    options += "<option value='5'#{' selected=true' if selected==5}>5</option>"
    options += "<option value='6'#{' selected=true' if selected==6}>6</option>"
    options += "<option value='7'#{' selected=true' if selected==7}>7</option>"
    options += "<option value='8'#{' selected=true' if selected==8}>8</option>"
    options += "<option value='9'#{' selected=true' if selected==9}>9</option>"
    options += "<option value='10'#{' selected=true' if selected==10}>10</option>"
    return options.html_safe
  end

  def options_for_symbol_margin_mode(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Forex [ lots * contract_size / leverage * percentage / 100 ]</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>CFD [ lots * contract_size * market_price * percentage / 100 ]</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Futures [ lots * initial_margin * percentage / 100 ]</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>CFD-Index [ lots * contract_size * market_price / tick_size * price * percentage / 100 ]</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>CFD-Leverage [ lots * contract_size * market_price / leverage * percentage / 100 ]</option>"
    return options.html_safe
  end

  def options_for_symbol_profit_mode(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>Forex[ (close_price - open_price) * contract_size * lots ]</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>CFD[ (close_price - open_price) * contract_size * lots ]</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Futures[ (close_price - open_price) * tick_price / tick_size * lots ]</option>"
    return options.html_safe
  end

  def options_for_symbol_swap_type(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>by points [ lots * long_or_short points * pointsize ]</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>by money [ lots * long_or_short ]</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>by interest [ lots * long_or_short / 100 / 360 ]</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>by money in margin currency [lots * long_or_short ]</option>"
    return options.html_safe
  end

  def options_for_symbol_swap_rollover3days(selected=nil)
    options = ""
    options += "<option value='1'#{' selected=true' if selected==1}>Monday</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>Tuesday</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>Wednesday</option>"
    options += "<option value='4'#{' selected=true' if selected==4}>Thursday</option>"
    options += "<option value='5'#{' selected=true' if selected==5}>Friday</option>"
    return options.html_safe
  end

  def group_securities(group, securities)
    output_string = ""
    first = true
    securities.each_with_index do |sec, si|
      if group["secgroups"][si]["show"].to_i==1 && sec["name"]!=""
        if first
          first = false
          output_string += sec["name"]
        else
          output_string += ", " + sec["name"]
        end
      end
    end
    return output_string
  end

  def options_for_group_default_leverage(selected=nil)
    options = ""
    options += "<option value='1000'#{' selected=true' if selected==1000}>1:1000</option>"
    options += "<option value='500'#{' selected=true' if selected==500}>1:500</option>"
    options += "<option value='400'#{' selected=true' if selected==400}>1:400</option>"
    options += "<option value='300'#{' selected=true' if selected==300}>1:300</option>"
    options += "<option value='200'#{' selected=true' if selected==200}>1:200</option>"
    options += "<option value='175'#{' selected=true' if selected==175}>1:175</option>"
    options += "<option value='150'#{' selected=true' if selected==150}>1:150</option>"
    options += "<option value='125'#{' selected=true' if selected==125}>1:125</option>"
    options += "<option value='100'#{' selected=true' if selected==100}>1:100</option>"
    options += "<option value='75'#{' selected=true' if selected==75}>1:75</option>"
    options += "<option value='66'#{' selected=true' if selected==66}>1:66</option>"
    options += "<option value='50'#{' selected=true' if selected==50}>1:50</option>"
    options += "<option value='33'#{' selected=true' if selected==33}>1:33</option>"
    options += "<option value='25'#{' selected=true' if selected==25}>1:25</option>"
    options += "<option value='20'#{' selected=true' if selected==20}>1:20</option>"
    options += "<option value='10'#{' selected=true' if selected==10}>1:10</option>"
    options += "<option value='5'#{' selected=true' if selected==5}>1:5</option>"
    options += "<option value='3'#{' selected=true' if selected==3}>1:3</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>1:2</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>1:1</option>"
    options += "<option value='0'#{' selected=true' if selected==0}></option>"
    return options.html_safe
  end

  def options_for_group_news(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>disable</option>"
    options += "<option value='1'#{' selected=true' if selected==1}>topics only</option>"
    options += "<option value='2'#{' selected=true' if selected==2}>full package</option>"
    return options.html_safe
  end

  def options_for_group_maxsecurities(selected=nil)
    options = ""
    options += "<option value='10'#{' selected=true' if selected==10}>10</option>"
    options += "<option value='30'#{' selected=true' if selected==30}>30</option>"
    options += "<option value='50'#{' selected=true' if selected==50}>50</option>"
    options += "<option value='4096'#{' selected=true' if selected==4096}>unlimited</option>"
    return options.html_safe
  end

  def options_for_group_maxpositions(selected=nil)
    options = ""
    options += "<option value='10'#{' selected=true' if selected==10}>10</option>"
    options += "<option value='30'#{' selected=true' if selected==30}>30</option>"
    options += "<option value='50'#{' selected=true' if selected==50}>50</option>"
    options += "<option value='0'#{' selected=true' if selected==0}>unlimited</option>"
    return options.html_safe
  end

  def options_for_group_rights(selected=nil)
    options = ""
    options += "<option value='1'#{' selected=true' if selected==1}>Disable</option>"
    options += "<option value='17'#{' selected=true' if selected==17}>Enable all signals from all brokers</option>"
    options += "<option value='33'#{' selected=true' if selected==33}>Enable signals from my servers only</option>"
    return options.html_safe
  end

  def options_for_group_archive_period(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>disabled</option>"
    options += "<option value='90'#{' selected=true' if selected==90}>90</option>"
    options += "<option value='180'#{' selected=true' if selected==180}>180</option>"
    options += "<option value='365'#{' selected=true' if selected==365}>365</option>"
    return options.html_safe
  end

  def options_for_group_archive_max_balance(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>0</option>"
    options += "<option value='100'#{' selected=true' if selected==100}>100</option>"
    options += "<option value='1000'#{' selected=true' if selected==1000}>1000</option>"
    options += "<option value='10000'#{' selected=true' if selected==10000}>10000</option>"
    return options.html_safe
  end

  def options_for_group_archive_pending_period(selected=nil)
    options = ""
    options += "<option value='0'#{' selected=true' if selected==0}>disabled</option>"
    (1..6).to_a.each do |i|
      options += "<option value='#{i}'#{' selected=true' if selected==i}>#{i}</option>"
    end
    return options.html_safe
  end

end
