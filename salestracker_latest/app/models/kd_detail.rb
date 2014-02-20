class KdDetail < ActiveRecord::Base
  # attr_accessible :title, :body
   set_table_name "KD_MASTER"
 
  alias_attribute :kd_code , :KD_code
  alias_attribute :kd_name , :KD_name
  
  
end
