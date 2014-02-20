class Employee < ActiveRecord::Base
  
  set_table_name "SALES_PERSONNEL"
 
  alias_attribute :branch_id, :branch_code
  alias_attribute :employee_code , :sales_person_code
  alias_attribute :name , :sales_person_name
  alias_attribute :supervisor_code , :supervisor
  
  
  attr_accessible :role , :company_code , :branch_id , :employee_code , :name , :phone , :supervisor_code ,:KD_code
  
  
  
#   GET ALL SALES REP DETAILS
  def self.get_all_sales_rep_details(date)
     response = Array.new
     # emp = Employee.find(:all, :conditions =>{:role_id => role_id,:is_active => '1'})
     emp = Employee.find(:all)

     emp.each do |val|
       sales_rep = Hash.new()
       
       code = val.employee_code
       name = val.name
       date_check = PlannedRoute.validates_date(val.employee_code,date)
       date_check1 = ActualRoute.validates_date(val.employee_code,date)
       if(!date_check || !date_check1)
         return 1
            # sales_rep['employee_code'] = code
            # sales_rep['name'] = name
            # response << sales_rep
       end  
      
     end
         return 0
    end
  
  
  #   GET ALL SALES REP DETAILS
  def self.get_all_sales_rep_count(date)
     # emp = Employee.find(:all, :conditions =>{:role_id => role_id,:is_active => '1'})
     emp = Employee.count(:all, :conditions =>{:is_active => '1'})
     
      if (emp.to_i > 0) 
          return false
       else
          return true
       end

  end
  
  
  # GET PURTICULAR SALES REP DETAILS 
  def self.get_sales_rep_details(code,date1)
    sales_rep_routes_array = Hash.new
     emp = Employee.find(:first, :conditions =>{:employee_code => code,:is_active => '1'})
            date_check = PlannedRoute.validates_date(emp.id,date1)
      if !date_check
         planned_routes = PlannedRoute.planned_routes_details(emp.id)
         actual_routes = ActualRoute.actual_routes_details(emp.id)
      
        sales_rep_routes_array['name'] = emp.name
        sales_rep_routes_array['phone_number'] = emp.phone
        sales_rep_routes_array['planned_path'] = planned_routes
        sales_rep_routes_array['actual_path'] = actual_routes  
       end 
     
      
      
     # planned = PlannedRoute.find(:all,:conditions =>{:employee_id => emp.id})
     # planned.each do |val|
#        
         # sales_rep_planned_routes_hash = Hash.new
         # sales_rep_planned_routes_hash['lat'] = val.lat
         # sales_rep_planned_routes_hash['lng'] = val.lng
         # sales_rep_planned_routes_hash['date'] = val.planned_date
         # sales_rep_planned_routes_hash['seq'] = val.seq
         # sales_rep_planned_routes_array << sales_rep_planned_routes_hash
#        
       # end        
    return sales_rep_routes_array
  end
  
  
  
    # GET PURTICULAR SALES REP CODE CHECK 
  def self.code_check(code)
      employee =Employee.count(:conditions => {:sales_person_code => code })
       if (employee.to_i > 0) 
          return false
       else
          return true
       end
  end
  
  
  
  # **************************** GET ALL  *********************************************
  def self.get_all_sales_rep_details_new(employee_code,date)
        response = Array.new
      sql=""
      employee =Employee.find(:first ,:conditions => {:sales_person_code => employee_code})
      
      role_id = (6 - employee.role_id).to_i
      
          sql << "select t"+role_id.to_s+".employee_code as employee_code, t"+role_id.to_s+".name as name, t"+role_id.to_s+".id as id from employees as t1"
          
      for i in 2..role_id
          sql << " LEFT JOIN employees AS t"+i.to_s+" ON t"+i.to_s+".supervisor_code = t"+(i-1).to_s+".employee_code"
      end
      
          sql << " WHERE t1.employee_code = "+employee_code.to_s

      s = Employee.find_by_sql(sql) 
      
       s.each do |val|
       sales_rep = Hash.new()
       
       code = val.employee_code
       name = val.name
       date_check = PlannedRoute.validates_date(val.id,date)
       if(!date_check)
            sales_rep['employee_code'] = code
            sales_rep['name'] = name
            response << sales_rep
       end  
      
     end
    return response     
  end
  
  
  def self.save_new_employee(employee_code,name)
     user1 = Employee.new(:employee_code => employee_code, :name => name)
      user1.save
      return user1
  end
   
   # **************************** SET DATE FORMATE *********************************************
  def self.date_formate(date)
     return "#{DateTime.parse(date).strftime("%Y-%m-%d %H:%M")}"
  end
  
  # **************************** SET DATE FORMATE *********************************************
  def self.date_formate1(date)
     return "#{DateTime.parse(date).strftime("%d-%b-%Y, %A")}"
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


# # **************************** SET DATE FORMATE *********************************************
  # def self.get_all_sales_rep_details_new(employee_code,date)
      # response = Array.new
      # sql=""
      # employee =Employee.find(:first ,:conditions => {:employee_code => employee_code})
#       
      # role_id = (6 - employee.role_id).to_i
#       
          # sql << "select t"+role_id.to_s+".employee_code as employee_code, t"+role_id.to_s+".name as name, t"+role_id.to_s+".id as id from employees as t1"
#           
      # for i in 2..role_id
          # sql << " LEFT JOIN employees AS t"+i.to_s+" ON t"+i.to_s+".supervisor_code = t"+(i-1).to_s+".employee_code"
      # end
#       
          # sql << " WHERE t1.employee_code = "+employee_code.to_s
# 
      # s = Employee.find_by_sql(sql) 
#       
#       
       # s.each do |val|
       # sales_rep = Hash.new()
#        
       # code = val.employee_code
       # name = val.name
       # date_check = PlannedRoute.validates_date(val.id,date)
       # if(!date_check)
            # sales_rep['employee_code'] = code
            # sales_rep['name'] = name
            # response << sales_rep
       # end  
#       
     # end
    # return response        
  # end
#   
  



end
