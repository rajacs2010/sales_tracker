class ProjectBase
  
  
  def self.get_gmt
    @d = Time.now()
    @d = @d.gmtime
    @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min)
    return "#{@mk.strftime('%Y-%m-%d %H:%M:%S')}"
  end
  
  def self.get_future_gmt(length,unit)
    @d = Time.now()
    @d = @d.gmtime
    if unit.to_s()=="m"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.months  
    elsif   unit.to_s()=="y"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.years
    elsif   unit.to_s()=="d"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.days
    elsif   unit.to_s()=="h"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.hours
    elsif   unit.to_s()=="l"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.minutes
    end
    return "#{@mk.strftime('%Y-%m-%d %H:%M:%S')}"
  end
  
  
  
  def self.get_future_fixed_gmt(length,unit,hour,min)
    @d = Time.now()
    @d = @d.gmtime
    if unit.to_s()=="m"
      @mk = Time.gm(@d.year,@d.month,@d.day, hour, min) + length.to_i.months  
    elsif   unit.to_s()=="y"
      @mk = Time.gm(@d.year,@d.month,@d.day, hour, min) + length.to_i.years
    elsif  unit.to_s()=="d"
      @mk = Time.gm(@d.year,@d.month,@d.day, hour, min) + length.to_i.days
    elsif   unit.to_s()=="h"
      @mk = Time.gm(@d.year,@d.month,@d.day, hour, min) + length.to_i.hours
    elsif   unit.to_s()=="l"
      @mk = Time.gm(@d.year,@d.month,@d.day, hour, min) + length.to_i.minutes
    end
    return "#{@mk.strftime('%Y-%m-%d %H:%M:%S')}"
  end
  
  
  #returns friendly labels for past time strings
  #few seconds ago, few minutes ago etc
  def self.friendly_gmt_past(past_time)
    current = Time.now() 
    current = current.gmtime
    record = Time.parse(past_time.to_s())
    if(current.year == record.year)
      #event happened an year ago
      if(current.month == record.month)
        if current.day == record.day
          if current.hour == record.hour
            if current.min == record.min
              string  = "few seconds ago"
            else
              #happened several minutes ago
              string = "#{(current.min - record.min).to_s()} minute(s) ago"  
            end
          else
            #happened several hours ago
            string = "#{(current.hour - record.hour).to_s()} hour(s) ago"  
          end
        else
          #event happened several days ago
          string = "#{(current.day - record.day).to_s()} day(s) ago"
        end
      else
        #events happened several months ago
        string = "#{(current.month - record.month).to_s()} month(s) ago"
      end
    else
      string = "#{(current.year - record.year).to_s()} year(s) ago"
    end
    
    return string.gsub("-","")
    
  end
  
  
  
  def self.get_offset_time(offset,length,unit)
    @d = Time.parse(offset)
    @d = @d.gmtime
    if unit.to_s()=="m"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.months  
    elsif   unit.to_s()=="y"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.years
    elsif   unit.to_s()=="d"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.days
    elsif  unit.to_s()=="h"
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) + length.to_i.hours
    end
    return "#{@mk.strftime('%Y-%m-%d %H:%M:%S')}"
  end
  
  
  
  def self.to_local_time(with_time,gmt_time,user_zone)
    
    begin
      if user_zone.to_s()!=""
        @time = user_zone.to_s().split("/")
        @hours = @time[1]
        @zone = @time[2].to_s().gsub(")","")
        @hours_min =@hours.to_s().split(":")
        if @hours_min[1].to_s()=="30"
          @hours_v = "#{@hours_min[0]}.5"
        else
          @hours_v = "#{@hours_min[0]}"
        end
      else
        @hours_v = 0
        @zone ="GMT"
      end
      
      @d = DateTime.parse(gmt_time)
      @mk = Time.gm(@d.year,@d.month,@d.day, @d.hour, @d.min) +@hours_v.to_f.hours
      
      if with_time.to_s()=='1'
        return  "#{@mk.strftime('%Y-%m-%d %H:%M:%S')}"
      else
        return "#{@mk.strftime('%Y-%m-%d')}"
      end
      
    rescue
      return gmt_time
    end
    
  end
  
  #checks if the env is production
  def self.is_production
    if RAILS_ENV == "development"
      return false
    else
      return true
    end
  end
  
  #Returns a float vaule
  def self.get_float(value)
    begin
      if value!=nil
        value = value.to_s()
        if value!=""
          return "%.2f" % value
        else
          return 0
        end
      else
        return 0
      end
    rescue
      return 0
    end
  end
  
  #Returns the substring of the returned text
  def self.sub_string(text,offset,limit)
    return text.to_s().chars[offset.to_i..limit.to_i]
  end
  
  #Returns a random code of the given @size
  #The random code will be a combination of A,a and numerals
  def self.random_code size
    chars = (('A'..'Z').to_a + ('a'..'z').to_a + ('0'..'9').to_a) - %w(0 O 1 l I)
     (1..size).collect{|a| chars[rand(chars.size)] }.join
    
  end
  
  
  def self.random_numbers size
    chars = (('0'..'9').to_a + ('0'..'9').to_a + ('0'..'9').to_a) - %w(0 O 1 l I)
     (1..size).collect{|a| chars[rand(chars.size)] }.join
  end
  
  def self.merge_date_time(cdate,time)
    if cdate.to_s()!=""
      return "#{cdate.to_s()} #{time.to_s()}"
    else
      return nil
    end
  end
  
  def self.split_date_time(date_time)
    arr = date_time.to_s().split(" ")
    return arr
  end
  
  def self.split_time(end_time)
    timearr = end_time.to_s().split(":")
    return timearr
  end
  
  def self.split_date(end_date)
    onlydatearr = end_date.to_s().split("-")
    return onlydatearr
  end
  
  
  def self.sanitize_filename(name)
    # get only the filename, not the whole path  
    name.gsub! /^.*(\\|\/)/, ''
    # If the name starts with periods upfront, remove them all.
    name.gsub! /^\.*/, ''
    
    if (name.empty?)
      return_fn = nil
    else
      
      #Check if the extension is a valid extension
      ex = name.split(".").last
      fn = name.split(".").first
      # Replace all non alphanumeric with underscores
      fn.to_s().gsub! /[^\w\-]/, '_' 
      if ((ex.empty?) || (fn.empty?))
        return_fn = nil
      else
        if (ex =~ /(doc|pdf|txt|jpg|gif|csv|png|jpeg)$/i)
          return_fn = fn + "." + ex
        else
          return_fn = nil
        end
      end 
    end
    return return_fn
  end
  
  def self.uri_encode(text)
    
    require 'cgi'
    return CGI::escape(text)
    
  end
  
  # sends a request to the mentioned url with the data
  #method takes the values GET , POST
  def self.send_request(method,url,data)
    require 'httpclient'
    require 'json'
    
    server = HTTPClient.new
    
    url = URI.escape(url)
    
    if(method == "post")
      respoll = server.post(url,data)
    elsif (method == "delete")
      respoll = server.delete(url)
    else
      respoll = server.get(url,data)
    end
    
    str = ""
    #@respoll = respoll
    res_stat = respoll.status
    #@stat = res_stat
    if res_stat == 200
      #json_data = JSON.parse(respoll.content)
      return respoll.content
    else
      return "hhh"
    end
    
  end 
  
  # sends a request to the mentioned url with the data
  #method takes the values GET , POST
  def self.bitly_send_request(url)
    require 'httpclient'
    require 'json'
    
    server = HTTPClient.new
    data = nil
    respoll = server.get(url,data)
    str = ""
    #@respoll = respoll
    res_stat = respoll.status
    #@stat = res_stat
    if res_stat == 200
      json_data = JSON.parse(respoll.content)
      return json_data
    else
      return nil
    end
    
  end 
  
  def self.test_send_request(method,url,data)
    require 'httpclient'
    require 'json'
    
    server = HTTPClient.new
    
    url = URI.escape(url)
    
    if(method == "post")
      respoll = server.post(url,data)
    elsif (method == "delete")
      respoll = server.delete(url)
    else
      respoll = server.get(url,data)
    end
    
    str = ""
    #@respoll = respoll
    res_stat = respoll.status
    #@stat = res_stat
    if res_stat == 200
      json_data = JSON.parse(respoll.content)
      return json_data
    else
      return respoll
    end
    
  end 
  
  def self.access_token(params,session,cookies)
    if ( cookies[:baeg_access_token] != nil )
      return cookies[:baeg_access_token].to_s() 
    else
      if( session[:user_id] != nil )
        user =   User.get_local_user(session[:user_id])
        if user !=nil
          user.access_token #return the aceess token
        else
          return nil #user not found in DB
        end
      else
        return nil #session not fond
      end
    end
  end
  
    def self.picplz_access_token(params,session,cookies)
    if ( cookies[:service_access_token] != nil )
      return cookies[:service_access_token].to_s() 
    else
      if( session[:local_service_user_id] != nil )
        user =   UserService.get_local_user(session[:local_service_user_id])
        if user !=nil
		  @oauth = OauthKey.find(:first, :conditions => {:user_id => user.user_id})	
		  return @oauth.access_token
        else
          return nil #user not found in DB
        end
      else
        return nil #session not fond
      end
    end
  end
  
  #converts the time stamp to date time
  def self.stamp_to_string(timestamp)
    t = Time.at(timestamp.to_i)
    tt = t.to_time
    return "#{tt.strftime('%b-%Y-%d %H:%M:%S')}"
  end
  
 #extracts  all the tags in the text
  def self.extract_tags(text)
	require "cgi"
    str = ""
    if((text.include? "@") || (text.include? "#"))
      words = text.split(" ")
      words.each{|w|
        
        if(w.include? "@")
           username = w.gsub("@","")
           str << "<a href=\"/search/#{username}\">#{w}</a>"
           str << " "
        elsif(w.include? "#")
           username = w.gsub("#","")
           str << "<a href=\"/tag-images/#{username}\">#{w}</a>"
           str << " "
		else
			str << "#{CGI.escapeHTML(w)}"
	        str << " "
		end
        
      }
      return str

    else
      return "#{CGI.escapeHTML(text)}"
    end
  end
  
end