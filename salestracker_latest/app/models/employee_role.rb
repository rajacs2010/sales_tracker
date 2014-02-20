class EmployeeRole < ActiveRecord::Base
  
  set_table_name "employee_roles"
  
  alias_attribute :role, :role1
  alias_attribute :role_description , :role_description1
#   
  attr_accessible :role, :role_description 
  before_create :set_created_at
  before_save :set_updated_at
  
     
  
  
   # set created date
    def set_created_at
      created_at = ProjectBase.get_gmt
    end
    
    # set updated at
    def set_updated_at
      uodated_at = ProjectBase.get_gmt
    end
end
