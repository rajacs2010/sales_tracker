class PlannedRoute < ActiveRecord::Base
  
     self.set_table_name "sale_data"
  attr_accessible :salesperson_code, :planned_date ,:seq , :lat , :lng, :customer_code
  # before_create :set_created_at
  # before_save :set_replaced_at
  alias_attribute :planned_date , :Date
  alias_attribute :seq , :sequence_number
  
  
  def self.planned_routes_details(id1,date1)
        sales_rep_planned_routes_array = Array.new

     # planned = PlannedRoute.find(:all,:conditions =>{:salesperson_code => id1,:Date => date1})
     planned = PlannedRoute.where("salesperson_code = ? and Date = ? and GPS_latitude is not null and GPS_longitude is not null",id1,date1)
     planned.each do |val|
       address = ""
         address = CustomerDetail.get_addtrss(val.customer_code) 
         sales_rep_planned_routes_hash = Hash.new
         sales_rep_planned_routes_hash['date'] = val.planned_date
         sales_rep_planned_routes_hash['seq'] = val.seq
         sales_rep_planned_routes_hash['customer'] = address
         sales_rep_planned_routes_array << sales_rep_planned_routes_hash
       
       end        
    return sales_rep_planned_routes_array
    
  end
  
  
     # check user email validate 
    def self.validates_date(emp_id,date)
      planned_date = date_formate(date)
      # planned_date = Date.strptime(date,'%Y-%m-%d')
      planned_route =PlannedRoute.count(:conditions => {:salesperson_code => emp_id,:Date => planned_date })
       if (planned_route.to_i > 0) 
          return false
       else
          return true
       end
  
    end 
  
  
  # **************************** SET DATE FORMATE *********************************************
  def self.date_formate(date)
     return "#{DateTime.parse(date).strftime("%Y-%m-%d")}"
  end
  
   # # set created date
    # def set_created_at
      # created_at = ProjectBase.get_gmt
    # end
#     
    # # set updated at
    # def set_updated_at
      # uodated_at = ProjectBase.get_gmt
    # end
end
