class BranchDetail < ActiveRecord::Base

 set_table_name "BRANCH_MASTER"
 
  alias_attribute :name, :branch_name
  alias_attribute :code, :branch_code
    
  attr_accessible :name ,:code
  # before_create :set_created_at
  # before_save :set_updated_at
  
    
  
  
  
   # set created date
    # def set_created_at
      # created_at = ProjectBase.get_gmt
    # end
#     
    # # set updated at
    # def set_updated_at
      # uodated_at = ProjectBase.get_gmt
    # end
end
