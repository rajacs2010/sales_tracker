class ActualRoute < ActiveRecord::Base
  
  set_table_name "GPS_DATA"
 
  alias_attribute :employee_id, :salesperson_code
  alias_attribute :lat, :GPS_latitude
  alias_attribute :lng, :GPS_longitude
  alias_attribute :gps_date, :GPS_Date
  alias_attribute :gps_time, :GPS_Time
    
  attr_accessible :employee_id, :gps_time ,:gps_date ,:lat ,:lng
  before_create :set_created_at
  before_save :set_replaced_at
  
  
  def self.actual_routes_details(id1,date)
    
     sales_rep_actual_routes_array = Array.new
     
     date1 = date_formate1(date)

     planned = ActualRoute.where("salesperson_code = ? and GPS_Date = ? and GPS_latitude is not null and GPS_longitude is not null", id1,date1)

     planned.each do |val|
       
         sales_rep_actual_routes_hash = Hash.new
         sales_rep_actual_routes_hash['lat'] = val.lat
         sales_rep_actual_routes_hash['lng'] = val.lng
         sales_rep_actual_routes_hash['date'] = val.gps_date
         sales_rep_actual_routes_hash['time'] = val.gps_time
         # sales_rep_actual_routes_hash['seq'] = val.seq
         sales_rep_actual_routes_array << sales_rep_actual_routes_hash
       
       end        
    return sales_rep_actual_routes_array
    
  end
  
  
    # check user email validate 
    def self.validates_date(emp_id,date)
      actual_date = PlannedRoute.date_formate(date)
      # planned_date = Date.strptime(date,'%Y-%m-%d')
      actual_route =ActualRoute.count(:conditions => {:salesperson_code => emp_id,:GPS_Date => actual_date })
       if (actual_route.to_i > 0) 
          return false
       else
          return true
       end
  
    end 
  
  
  
  # **************************** SET DATE FORMATE *********************************************
  def self.date_formate1(date)
     return "#{DateTime.parse(date).strftime("%Y-%m-%d")}"
  end
  
  
   # set created date
    def set_created_at
      created_at = ProjectBase.get_gmt
    end
    
    # set updated at
    def set_updated_at
      uodated_at = ProjectBase.get_gmt
    end
end
