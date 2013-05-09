require 'net/http'
require 'cgi/cookie'

class ApiMethods

  API_URL = 'https://54.228.192.136/rpc/apiserv'
  JSON_ESCAPE_MAP = {
    '\\'    => '\\\\',
    '</'    => '<\/',
    "\r\n"  => '\n',
    "\n"    => '\n',
    "\r"    => '\n',
    '"'     => '\\"' }
  attr_accessor :uri, :http, :request

  def initialize
    @uri = URI.parse(API_URL)
    @http = Net::HTTP.new(@uri.host, @uri.port)
    if @uri.scheme == "https"
      @http.use_ssl = true
      @http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    @request = Net::HTTP::Post.new(uri.path)
    @request.content_type = 'application/json'
  end

  def checkCookieValid(session)
    if session["session_expires"] && session["session_expires"] > Time.now
      return true
    else
      return false
    end
  end

  def self.ip2long(ip)
    long = 0
    address = ip.split(':').first
    address.split(/\./).each_with_index do |b, i|
      long += b.to_i << ( 8*i )
    end
    long
  end

  def self.long2ip(long)
    ip = []
    4.times do |i|
      ip.push(long.to_i & 255)
      long = long.to_i >> 8
    end
    ip.join(".")
  end

  def login(session, userid, password)
    request.body = '{"method":"login","server":"54.246.36.182:443","userid":'+userid+',"password":"'+password+'"}'
    http.start do
      http.request(request) do |res|
        cookies  = CGI::Cookie.parse(res['Set-Cookie']);
        response = JSON.parse(res.body)
        if response["success"] == true
          session["session_cookie"] = cookies["cppcms_session"].to_s
          session["session_expires"] = 3.minutes.from_now
          session["api_userid"] = userid
          session["api_password"] = password
          return true
        else
          session["session_cookie"] = nil
          session["session_expires"] = nil
          session["api_userid"] = nil
          session["api_password"] = nil
          return false
        end
      end
    end
  end

  def getData(request_body,session)
    unless checkCookieValid(session)
      login(session,session["api_userid"],session["api_password"])
    end
    request.body = request_body.html_safe
    request["Accept"] = "application/json"
    request["Cookie"] = session["session_cookie"]
    http.start do
      http.request(request) do |res|
        response = JSON.parse(res.body)
        if response["success"] == true
          session["session_expires"] = 3.minutes.from_now
          return response["answer"]
        else
          return nil
        end
      end
    end
  end

  def updateData(update_string,session)
    unless checkCookieValid(session)
      login(session,session["api_userid"],session["api_password"])
    end
    request.body = update_string.html_safe
    request["Cookie"] = session["session_cookie"]
    http.start do
      http.request(request) do |res|
        response = JSON.parse(res.body)
        if response["success"] == true
          session["session_expires"] = 3.minutes.from_now
          return {:success => true, :msg => "All good"}
        else
          return {:success => false, :msg => response["msg"]}
        end
      end
    end
  end

  def getCommon(session)
    return getData('{"method":"CfgRequestCommon"}', session)
  end

  def updateCommon(data,session)
    update_string = ""
    data.keys.each_with_index do |key, ix|
      if key == "optimization_t"
        data[:optimization_time] = data[:optimization_t][:optimization_time_h].to_i * 60 + data[:optimization_t][:optimization_time_m].to_i
        update_string += ',' unless ix==0
        update_string += '{"field": "optimization_time", "value": '+data[:optimization_time].to_s+'}'
      elsif key == "web_adresses"
        web_adresses = "["
        data[key].values.each_with_index do |value, inx|
          web_adresses += ',' unless inx==0
          web_adresses += ApiMethods.ip2long(value.to_s).to_s
        end
        web_adresses += "]"
        update_string += ',' unless ix==0
        update_string += '{"field": "'+key.to_s+'", "value": '+web_adresses+'}'
      elsif key == "adapter"
        index = data[:adapter][:selected_adapter].to_i
        array = data[:adapter][:full_adapter_list].split('|')
        store = array[index]
        array.delete_at(index)
        array.insert(0, store)
        adapters = array.join('|') + '|'
        update_string += ',' unless ix==0
        update_string += '{"field": "adapters", "value": "'+adapters+'"}'
      else
        update_string += ',' unless ix==0        
        if key=="name"||key=="timesync"||key=="path_database"||key=="path_history"||key=="path_log"
          update_string += '{"field": "'+key.to_s+'", "value": "'+data[key].to_s.gsub(/(\\|<\/|\r\n|[\n\r"])/) { JSON_ESCAPE_MAP[$1] }+'"}'
        else
          update_string += '{"field": "'+key.to_s+'", "value": '+data[key].to_s+'}'
        end
      end
    end
    update_string = '{"method": "CfgUpdateCommon", "update": ['+update_string+']}'
    return updateData(update_string, session)
  end

  def getTime(session)
    return getData('{"method":"CfgRequestTime"}', session)
  end

  def updateTime(data,session)
    update_string = '{"method": "CfgUpdateTime", "field": "days", "value" : '+data.to_s+'}'
    return updateData(update_string, session)
  end

  def getBackup(session)
    return getData('{"method":"CfgRequestBackup"}', session)
  end

  def updateBackup(data,session)
    update_string = ""
    data.keys.each_with_index do |key, ix|
      if key == "fullbackup_shift"
        time = data[key][:hour].to_i * 60 + data[key][:minute].to_i
        update_string += ',' unless ix==0
        update_string += '{"field": "'+key+'", "value": '+time.to_s+'}'
      else
        if key=="fullbackup_path"||key=="export_path"||key=="export_securities"||key=="external_path"
          update_string += ',' unless ix==0     
          update_string += '{"field": "'+key.to_s+'", "value": "'+data[key].to_s.gsub(/(\\|<\/|\r\n|[\n\r"])/) { JSON_ESCAPE_MAP[$1] }+'"}'
        else
          update_string += ',' unless ix==0     
          value = data[key].to_s == "" ? "0" : data[key].to_s
          update_string += '{"field": "'+key.to_s+'", "value": '+value+'}'
        end
      end
    end
    update_string = '{"method": "CfgUpdateBackup", "update": ['+update_string+']}'
    return updateData(update_string, session)
  end

  def getSymbolGroup(session)
    return getData('{"method":"CfgRequestSymbolGroup"}', session)
  end

  def updateSymbolGroup(data,session)
    update_string = ""
    position = ""
    pos = 0
    data.keys.each_with_index do |key, ix|
      if key == "position"
        position = data[key]
        pos = ix+1
      else
        if key=="name"||key=="description"
          update_string += ',' unless ix==0 || ix==pos
          update_string += '{"field": "'+key.to_s+'", "value": "'+data[key].to_s.gsub(/(\\|<\/|\r\n|[\n\r"])/) { JSON_ESCAPE_MAP[$1] }+'"}'
        else
          if data[key].to_s != ""
            update_string += ',' unless ix==0 || ix==pos
            update_string += '{"field": "'+key.to_s+'", "value": '+data[key].to_s+'}'
          end
        end
      end
    end
    update_string = '{"method": "CfgUpdateSymbolGroup", "position" : '+position+', "update": ['+update_string+']}'
    return updateData(update_string, session)
  end

  def getSymbol(session)
    return getData('{"method":"CfgRequestSymbol"}', session)
  end

  def updateSymbol(data,session)
  end

  def deleteSymbol(position,session)
  end

  def getHoliday(session)
    return getData('{"method":"CfgRequestHoliday"}', session)
  end

  def updateHoliday(data,session)
    update_string = ""
    position = ""
    pos = 0
    data.keys.each_with_index do |key, ix|
      if key == "from" || key == "to"
        update_string += ',' unless ix==0 || ix==pos
        time = data[key][:hour].to_i * 60 + data[key][:minute].to_i
        update_string += '{"field": "'+key.to_s+'", "value": '+time.to_s+'}'
      elsif key == "position"
        position = data[key]
        pos = ix+1
      else
        if key=="symbol"||key=="description"
          update_string += ',' unless ix==0 || ix==pos
          update_string += '{"field": "'+key.to_s+'", "value": "'+data[key].to_s.gsub(/(\\|<\/|\r\n|[\n\r"])/) { JSON_ESCAPE_MAP[$1] }+'"}'
        else
          if data[key].to_s != ""
            update_string += ',' unless ix==0 || ix==pos
            update_string += '{"field": "'+key.to_s+'", "value": '+data[key].to_s+'}'
          end
        end
      end
    end
    update_string = '{"method": "CfgUpdateHoliday", "position": '+position.to_s+', "update": ['+update_string+']}'
    puts update_string
    return updateData(update_string, session)
  end

  def deleteHoliday(position,session)
    update_string = '{"method": "CfgDeleteHoliday", "position": '+position.to_s+'}'
    return updateData(update_string, session)
  end

  def getSecurity(session)
    return getData('{"method":"CfgRequestSymbolGroup"}', session)
  end

  def getAccess(session)
    return getData('{"method":"CfgRequestAccess"}', session)
  end

  def updateAccess(data,session)
    update_string = ""
    position = ""
    pos = 0
    data.keys.each_with_index do |key, ix|
      if key == "from"
        update_string += ',' unless ix==0 || ix==pos
        update_string += '{"field": "from", "value": '+ApiMethods.ip2long(data[key]).to_s+'}'
      elsif key == "to"
        update_string += ',' unless ix==0 || ix==pos
        update_string += '{"field": "to", "value": '+ApiMethods.ip2long(data[key]).to_s+'}'
      elsif key == "position"
        position = data[key]
        pos = ix+1
      else
        update_string += ',' unless ix==0 || ix==pos
        if key=="comment"
          update_string += '{"field": "'+key.to_s+'", "value": "'+data[key].to_s.gsub(/(\\|<\/|\r\n|[\n\r"])/) { JSON_ESCAPE_MAP[$1] }+'"}'
        else
          update_string += '{"field": "'+key.to_s+'", "value": '+data[key].to_s+'}'
        end
      end
    end
    update_string = '{"method": "CfgUpdateAccess", "position": '+position.to_s+', "update": ['+update_string+']}'
    return updateData(update_string, session)
  end

  def deleteAccess(position,session)
    update_string = '{"method": "CfgDeleteAccess", "position": '+position.to_s+'}'
    return updateData(update_string, session)
  end

  def getDataServer(session,position=nil)
    return getData('{"method":"CfgRequestDataServer"'+( position.nil? ? '' : (', "position": ' + position.to_s) )+'}', session)
  end

  def updateDataServer(data,session)
    update_string = ""
    position = ""
    pos = 0
    data.keys.each_with_index do |key, ix|
      if key == "server"
        update_string += ',' unless ix==0 || ix==pos
        update_string += '{"field": "ip", "value": '+ApiMethods.ip2long(data[key]).to_s+'}'
        update_string += ',{"field": "server", "value": "'+data[key]+'"}'
      elsif key == "ip_internal"
        update_string += ',' unless ix==0 || ix==pos
        update_string += '{"field": "ip_internal", "value": '+ApiMethods.ip2long(data[key]).to_s+'}'
      elsif key == "position"
        position = data[key]
        pos = ix+1
      else
        update_string += ',' unless ix==0 || ix==pos
        if key=="description"
          update_string += '{"field": "'+key.to_s+'", "value": "'+data[key].to_s.gsub(/(\\|<\/|\r\n|[\n\r"])/) { JSON_ESCAPE_MAP[$1] }+'"}'
        else
          update_string += '{"field": "'+key.to_s+'", "value": '+data[key].to_s+'}'
        end
      end
    end
    update_string = '{"method": "CfgUpdateDataServer", "position": '+position.to_s+', "update": ['+update_string+']}'
    return updateData(update_string, session)
  end

  def deleteDataServer(position,session)
    update_string = '{"method": "CfgDeleteDataServer", "position": '+position.to_s+'}'
    return updateData(update_string, session)
  end

  def ping(session)
    if checkCookieValid(session)
      updateData('{"method":"Ping"}', session)
    else
      login(session,session["api_userid"],session["api_password"])
    end
  end
end