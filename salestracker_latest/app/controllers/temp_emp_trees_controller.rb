class TempEmpTreesController < ApplicationController
  
  
  def temp_table
    
    # arr = Array.new
    
     code = params['code']       
      if code.present?      
            emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => code })
            if emolpyee_code.present?
              emolpyee_role = emolpyee_code.role
            
              # if emolpyee_role == "WWCV" || emolpyee_role == "FMCL"
                code = emolpyee_code.employee_code
                if(!Employee.code_check(code) && TempEmpTree.supervisor_code_check(code))
                    
                      all_details = TempEmpTree.temp_table_details(code)
                      all_details1 = TempEmpTree.get_temp_table_detail(code)
                      higher_post_details = TempEmpTree.get_login_higher_post(code)
                      company_details = TempEmpTree.get_company_code(code)
    
                      json = {'success' => 1,'message' => all_details1,"high_post" => higher_post_details,"company_details" => company_details}
                 else
                      details = set_filter(emolpyee_code.employee_code,emolpyee_role)
                      json = details
                end  
                # else
                  # details = set_filter(emolpyee_code.employee_code,emolpyee_role)
                      # json = details
               # end
              
          else
             json = {"success" => 0, "message" => "logout"}
          end     
      else
        json = {'success' => 0,'message' => 'Required field missing'}
      end    
        render :json => json  
    end
  
  
  
  
  
  
#   temptable 1
     def temp_table1
    
    # arr = Array.new  
     code = params['code'] 
     # role = params['role']      
      if code.present?      
                if(!Employee.code_check(code))
                    
                      # all_details1 = TempEmpTree.get_login_lower_post(code)
                      all_details = TempEmpTree.temp_table_details(code)
                      all_details1 = TempEmpTree.get_temp_table_detail(code)
                      higher_post_details = TempEmpTree.get_login_higher_post(code)
                      company_details = TempEmpTree.get_company_code1(code)
    
                      json = {'success' => 1,'message' => all_details1,"high_post" => higher_post_details,"company_details" => company_details}
                      else
                      json = {'success' => 0,'message' => 'Please Select SR'}
                end  
          else
             json = {"success" => 0, "message" => "logout"}
          end     
   
        render :json => json  
    end
    
  
  
  
  def set_filter(login_id,role)
    arr= Array.new
    arr= Array.new
    all_details1 = ""
    higher_post_details ="",company_details =""
    
    if role == "KD"
        kd_details = KdDetail.find(:first, :conditions => {:KD_code => login_id})
        all_details1 = kd_details
        get_data = Employee.find(:all, :conditions => {:KD_code => kd_details.id})
    elsif role == "FMCL KD"
        get_data = Employee.where("company_code = ? and supervisor is null","FMCL");
        # get_data = Employee.find(:all, :conditions => {:supervisor => "" , :company_code => "FMCL"})
    elsif role == "ALL" 
        get_data = Employee.where("supervisor is null");
        # get_data = Employee.find(:all, :conditions => {:supervisor => ""})
    else
              get_data = Employee.where("company_code = ? and supervisor is null",role);

        # get_data = Employee.find(:all, :conditions => {:supervisor => "" , :company_code => role })

    end
   


    get_data.each do |val|
      details = ""
      
      if role == "KD"
          details = Employee.find(:first , :conditions => {:sales_person_code => val.employee_code})
      elsif role == "FMCL KD" || role == "ALL"
          details = Employee.find(:first , :conditions => {:supervisor => val.employee_code})
      else
          details = Employee.find(:first , :conditions => {:supervisor => val.employee_code})
      end
      
      if (!details.blank?)
          arr << val
          higher_post_details = TempEmpTree.get_login_higher_post(val.employee_code)
                
          if role == "ALL"
              company_details = TempEmpTree.get_company_code(login_id)
          else
              company_details = TempEmpTree.get_company_code1(val.employee_code)

          end
           # TempEmpTree.temp_table_details(val.employee_code)    
      end
    end

    
     if role == "KD" || role == "FMCL KD" || role == "ALL"
          TempEmpTree.temp_table_get_all_details(login_id,arr,0)
     else
          TempEmpTree.temp_table_get_all_details(login_id,arr,1)       
     end
          
         all_details1 = TempEmpTree.get_temp_table_detail(login_id)
         
                         # return all_details1

          
          if role == "KD"
               all_details1_length = all_details1.length
              all_details1[all_details1_length] = kd_details
          end
       
       json = {'success' => 1,'message' => all_details1,"high_post" => higher_post_details,"company_details" => company_details}
    return json
  end
  
end


  


  def sample
    render :json => TempEmpTree.get_login_higher_post("510002")
  
  end
  


 # n =1
    # all_details.each do |level_cate|
#       
      # if n != level_cate.level
           # n =n + 1
      # end
#       
      # hash_main = Hash.new
      # hash_main['level'] = n
      # # hash = Hash.new
      # # hash['level'] = level_cate.level
      # # hash['employee_code'] = level_cate.employee_code
      # # hash['manager_code'] = level_cate.manager_code
      # # hash['employee_name'] = level_cate.employee_name
#       
      # arr << hash
#       
    # end