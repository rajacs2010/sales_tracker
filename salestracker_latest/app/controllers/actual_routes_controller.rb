class ActualRoutesController < ApplicationController
 
 
 
 def last_viewed_location
   
    code = params['id']
    
    
   response =""
   details1 = ""
   sales_rep_routes_array = Hash.new   
   
   if code.present?
      if(!Employee.code_check(code))
        
            emp = Employee.find(:first, :conditions =>{:sales_person_code => code})
            details = ActualRoute.find(:all ,:conditions =>{:salesperson_code => emp.employee_code}, :order => "GPS_Date desc", :limit => 1)

              
               details.each do |val|
                    # date1 = ActualRoute.date_formate1("#{val.gps_date}#{ }#{val.gps_time}")
                    date1 = val.gps_date.to_s
               
                    planned_routes = PlannedRoute.planned_routes_details(emp.employee_code,date1)
                    actual_routes = ActualRoute.actual_routes_details(emp.employee_code,date1)
                
                    sales_rep_routes_array['date'] = date1
                    sales_rep_routes_array['name'] = emp.name
                    sales_rep_routes_array['planned_path'] = planned_routes
                    sales_rep_routes_array['actual_path'] = actual_routes
                    sales_rep_routes_array['last_record'] = 1
            
              end
              
            if (details.present?)
                response = {'success' => '1','message' => sales_rep_routes_array}   
            else
                response = {'success' => '0','message' => 'No data Found'}
            end  

        else
          response = {'success' => '0','message' => 'Please Select SR'}
  
        end
        
      else
        response = {'success' => '0','message' => 'Required field missing'}
      end
  
      
   render :json => response
    
   end


end
