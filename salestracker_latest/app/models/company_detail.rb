class CompanyDetail < ActiveRecord::Base
  
  set_table_name "COMPANY_MASTER"
  
  alias_attribute :name, :company_name
  
  
  attr_accessible :company_code, :name 
  # before_create :set_created_at
  # before_save :set_updated_at
#   
#   
#   
#   
#   
#   
#   
#   
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
