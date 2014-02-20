class EmployeeAuthenticationsController < ApplicationController


# Create new user 
 def create_new_user
  user_code = params['user_code']
  password = params['password']
  name = params['name']
  role = params['role']
  
    if user_code.present? && password.present? && name.present? && role.present?
      
       if(EmployeeAuthentication.validates_uniqueness(user_code))
          if(EmployeeAuthentication.validates_uniqueness1(user_code))
              new_employee = EmployeeAuthentication.create_employee(user_code,password,name,role)
              json = {"success" => 2, "message" => "User Created"}

          else
              new_employee = EmployeeAuthentication.create_employee1(user_code,password,name,role)
            json = {"success" => 2, "message" => "User Created"}
          end
        else
          new_employee = EmployeeAuthentication.update_employee(user_code,password,name,role)
         
          json = {"success" => 2, "message" => "User Password Updated"}
        end
     elsif user_code.present?     
          json = {"success" => 1, "message" => EmployeeAuthentication.get_employee_details(user_code)}
     end
         render :json => json
 end


# User login window
  def login_user
   
   user_code = params['user_code']
   password = params['password']
  
    if user_code.present? && password.present?
      
       if(!EmployeeAuthentication.validates_uniqueness(user_code))

 
            user = EmployeeAuthentication.authenticate(user_code, password)
            
            
           if (user != "1")
               login_response = EmployeeAuthentication.login_response(user)
               json = {"success" => 1, "message" => login_response}
           else    
               json = {"success" => 0, "message" => "Please Enter Correct Password"}
           end
        else
          json = {"success" => 0, "message" => "Please Enter Correct Username & Password"}
        end
       else
           json = {"success" => 0, "message" => "Sorry something missing"}
       end
   
         render :json => json
   
  end
  
  
end
