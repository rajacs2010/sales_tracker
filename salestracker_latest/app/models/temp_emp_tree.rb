class TempEmpTree < ActiveRecord::Base
  attr_accessible :login_employee, :level , :employee_code, :employee_name, :manager_code,:role
  
  def self.all_employees(login_employee,level)
      all_employees =  TempEmpTree.find(:all , :conditions => {:level => level, :login_employee => login_employee})
      return all_employees      
  end
  
  def self.subordinates(employee_code)
    all_employees =  Employee.find(:all , :conditions => {:supervisor => employee_code})
    return all_employees    
  end
  
   def self.subordinates1(employee_code)
    # all_employees =  Employee.find(:all , :conditions => {:supervisor => employee_code , :KD_code => ""})
    all_employees =  Employee.where("supervisor = ? and KD_code is null",employee_code)
    return all_employees    
  end
  
  
  def self.create_new_entry(login_employee, level, employee_code, employee_name, manager_code,role)
    
    created = TempEmpTree.new(:login_employee => login_employee, :level => level, :employee_code => employee_code, :employee_name => employee_name, :manager_code => manager_code, :role =>role)
    created.save
    
  end
  
  def self.is_subordinates_exist(login_employee, level)
      employee =TempEmpTree.count(:conditions => {:login_employee => login_employee, :level => level })
       if (employee.to_i > 0) 
          return true
       else
          return false
       end
  end
  
  
  def self.temp_table_details_store(login_employee,max_level,req)
    
    # get all employees using current max_level
      all_employee = TempEmpTree.all_employees(login_employee, max_level)
            
        all_employee.each do |every_employees|
          subordinates =""
            if req == 0
             subordinates = TempEmpTree.subordinates(every_employees.employee_code) 
            else
             subordinates = TempEmpTree.subordinates1(every_employees.employee_code) 
            end
            
            subordinates.each do |every_subordinate|
              
                   # employee_role1 = EmployeeRole.find(:first, :conditions =>{:id => every_subordinate.role_id})

                 TempEmpTree.create_new_entry(login_employee, max_level + 1, every_subordinate.employee_code, every_subordinate.name, every_employees.employee_code,every_subordinate.role)
            end
        end
  end
    
    
  def self.check_subornates_check(login_employee,max_level)
    
      is_subordinates_exist = TempEmpTree.is_subordinates_exist(login_employee, max_level + 1)
        
        if is_subordinates_exist
          
          return true
          
        else
           return false          
        end
  end  
  
  
  
  
  def self.temp_table_details(employee_id)
    
    max_level = 1;
       
    no_subordinates_found = true;
    sub_count = 0;
    
   login_employee = employee_id
        
    employee_code = login_employee
    
     employee_details = Employee.find(:first, :conditions =>{:sales_person_code => login_employee})
     # employee_role = EmployeeRole.find(:first, :conditions =>{:id => employee_details.role_id})
        
    TempEmpTree.create_new_entry(login_employee, max_level, employee_code,employee_details.name,"NULL",employee_details.role)
    
      # return 
    
    while no_subordinates_found == true 
      
        temp_table_details_store(login_employee,max_level,0)
        
        no_subordinates_found = check_subornates_check(login_employee,max_level)
        
        max_level = max_level + 1;
      
      end
     
  end
  
  
  
  def self.temp_table_get_all_details(all_employee,employee_details,req)
    
    max_level = 1;
       
    no_subordinates_found = true;
    sub_count = 0;
    
    login_employee = all_employee
    employee_details.each do |every_employee|
      
        # employee_details = Employee.find(:first, :conditions =>{:employee_code => login_employee})
        # employee_role = EmployeeRole.find(:first, :conditions =>{:id => every_employee.role_id})
        
        TempEmpTree.create_new_entry(login_employee, max_level, every_employee.employee_code,every_employee.name,"NULL",every_employee.role)
      
    end
   
    while no_subordinates_found == true 
      
              
         temp_table_details_store(login_employee,max_level,req)
        
        no_subordinates_found = check_subornates_check(login_employee,max_level)
        
            
               max_level = max_level + 1;

      end
     
  end
  
  
  
  # get temp tree details 
  def self.get_temp_table_detail(emp_code)
    
      max = TempEmpTree.maximum("level") 
      # min = TempEmpTree.minimum("level") 
      
      i = 1
      arr = Array.new
      
      if (max.to_i >= 1)
         for i in 1..max
              all_details = TempEmpTree.find(:all , :conditions =>{:login_employee => emp_code ,:level => i} ) 
              # hash = Hash.new
              # hash['level'] = i
              # hash['details'] = get_details(all_details)
              arr << all_details
              
      end       
      end
     
       
             # return max

        TempEmpTree.delete_all(:login_employee =>emp_code)
        
        return arr
  end
  
  def self.get_details(all_details)
             arr1 = Array.new
     all_details.each do |val|
                    hash = Hash.new
                    hash['employee_code'] = val.employee_code
                    hash['manager_code'] = val.manager_code
                    hash['employee_name'] = val.employee_name
                arr1 << hash
              end    
              
     return arr1     
  end
  
  
  
#   get higher post 
  def self.get_login_higher_post(login_employee)
        arr = Array.new
        no_subordinates_found = true
         employee_details = Employee.find(:first, :conditions =>{:sales_person_code => login_employee})
         
         while no_subordinates_found == true 
            employee_details1 = (employee_details.supervisor_code).to_s

            if employee_details1.present?
                employee_details = ""
                 employee_details = Employee.find(:first, :conditions =>{:sales_person_code => employee_details1})
                  # employee_role = EmployeeRole.find(:first, :conditions =>{:id => employee_details.role_id})
                    hash =Hash.new
                    hash['employee_code'] = employee_details.employee_code
                    hash['manager_code'] = employee_details.supervisor_code
                    hash['employee_name'] = employee_details.name
                    hash['role'] = employee_details.role
                    arr1 = Array.new

                arr1 << hash
                arr << arr1
                
            else    
                no_subordinates_found = false 
            end
            
         end

      return arr
  end
  
  #   get lower post 
  def self.get_login_lower_post(login_employee)
        arr = Array.new
        no_subordinates_found = true
         employee_details = Employee.find(:first, :conditions =>{:sales_person_code => login_employee})
         
         while no_subordinates_found == true 
                
                employee_details1 = (employee_details.employee_code).to_s
            
            if employee_details1.present?
              

                employee_details = ""
                 employee_details = Employee.find(:first, :conditions =>{:supervisor => employee_details1})
                  # employee_role = EmployeeRole.find(:first, :conditions =>{:id => employee_details.role_id})
                   if employee_details.present?
                     
                      hash =Hash.new
                    hash['employee_code'] = employee_details.employee_code
                    hash['manager_code'] = employee_details.supervisor_code
                    hash['employee_name'] = employee_details.name
                    # hash['role'] = employee_role.role
                    arr1 = Array.new

                    arr1 << hash
                      arr << arr1
                   else    
                      no_subordinates_found = false    
                   end
                   
                
            else    
                no_subordinates_found = false 
            end
            
         end

      return arr
  end
  
  
  # get company details 
  
  def self.get_company_code(login_code)
         arr = Array.new
         employee_details = Employee.find(:all, :conditions =>{:sales_person_code => login_code})
           if employee_details.blank?
                employee_details = Employee.where("supervisor is null")
           end
           
         employee_details.each do |val|
           
         details = Employee.find(:first , :conditions => {:supervisor => val.employee_code})
            
            if (!details.blank?)
              hash =Hash.new
              
              hash['employee_code'] = val.company_code
              hash['manager_code'] = val.supervisor_code
              hash['employee_name'] = val.company_code
              hash['role'] = "company"
              arr << hash
            end
         end
    return arr
  end
  
  
  # get company details 
  
  def self.get_company_code1(login_code)
         arr = Array.new
         employee_details = Employee.find(:first, :conditions =>{:sales_person_code => login_code})
              hash =Hash.new
              
              hash['employee_code'] = employee_details.company_code
              hash['manager_code'] = employee_details.company_code
              hash['employee_name'] = employee_details.company_code
              hash['role'] = "company"
              arr << hash
                 
    return arr
  end
  
  
  
 def self.supervisor_code_check(login_code)
         employee_details = Employee.find(:first, :conditions =>{:supervisor => login_code})
         employee_details1 = Employee.find(:first, :conditions =>{:sales_person_code => login_code})
        if employee_details.blank? && !employee_details1.supervisor_code.present?
          return false
        else
          return true  
        end
 end
end
