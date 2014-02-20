class CustomerDetail < ActiveRecord::Base
  # attr_accessible :title, :body
 set_table_name "CUSTOMER_MASTER"
  
    alias_attribute :address_line1, :Address_line1
  alias_attribute :address_line2, :Address_line2
  alias_attribute :address_line3, :Address_line3
  alias_attribute :lat, :GPS_latitude
  alias_attribute :lng, :GPS_longitude
  
    attr_accessible :address_line1, :address_line2 ,:address_line3 , :lat , :lng, :customer_name , :company_code


 # GET IMAGE ADDRESS
  def self.get_addtrss(customer_code)
    
      sql=""
      s =""
      arr = Array.new
      address = ""
      hash = Hash.new
        # sql << "select customer_name,Address_line1,Address_line2,Address_line3,city from CUSTOMER_MASTER where customer_code = "+customer_code
            # sql << "select * from uploaded_images where employee_id= 28 order by employee_id desc limit 9,9"
            s = CustomerDetail.find(:first,:conditions =>{:customer_code => customer_code}) 
           
           arr = [s.address_line1,s.address_line2,s.address_line3,s.city]
            arr.each do |val|
              if address.present?
                 address = "#{address}#{','}"
              end
              if val.present?
                 address = "#{address}#{val}"
              end
              
            end
            hash['address'] = address
            # hash['phone_number'] = s.phone_number
            hash['name'] = s.customer_name
            hash['lat'] = s.lat
            hash['lng'] = s.lng
            
       return hash   
  end

end
