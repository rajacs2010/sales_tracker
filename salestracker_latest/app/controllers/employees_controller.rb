class EmployeesController < ApplicationController

  
# ************************************  GET ALL SALES REP DETAILS   ************************************
  def get_all_sales_rep
    # role_id = params['role']
    date = params['date']
    
    if date.present?
      employee = Employee.get_all_sales_rep_details(date)
      # employee = Employee.get_all_sales_rep_count(date)
      if (employee == 1)
          response = {'success' => '1','message' => "#{'No Data Found '}#{Employee.date_formate1(date).upcase}"}
      else
          response = {'success' => '0','message' => "#{'No Data Found '}#{Employee.date_formate1(date).upcase}"}
      end
    else
      response = {'success' => '0','message' => 'Required field missing'}
    end
    render :json => response
    
  end
  
  
  
  # ************************************  GET PARTICULAR SALES REP DETAILS   ************************************
  def get_sales_rep_details
    code = params['id']
    date1 = params['date']

    
    if code.present? && date1.present?
      if(!Employee.code_check(code))
        # employee = Employee.get_sales_rep_details(code,date1)
        
         sales_rep_routes_array = Hash.new
        emp = Employee.find(:first, :conditions =>{:sales_person_code => code})
            date_check = PlannedRoute.validates_date(code,date1)
            date_check1 = ActualRoute.validates_date(code,date1)
      if !date_check || !date_check1
        
        # check last date
         details = ActualRoute.find(:all ,:conditions =>{:salesperson_code => emp.employee_code}, :limit => 1)
         # date2 = ActualRoute.date_formate1(details[0].gps_date.to_s)


         planned_routes = PlannedRoute.planned_routes_details(emp.employee_code,date1)
         actual_routes = ActualRoute.actual_routes_details(emp.employee_code,date1)
      
        sales_rep_routes_array['date'] = date1
        sales_rep_routes_array['name'] = emp.name
        # sales_rep_routes_array['phone_number'] = emp.phone
        sales_rep_routes_array['planned_path'] = planned_routes
        sales_rep_routes_array['actual_path'] = actual_routes  
        
        if date1.to_date == (details[0].gps_date).to_date
                    sales_rep_routes_array['last_record'] = 1
        else
                    sales_rep_routes_array['last_record'] = 0
        end
        
        response = {'success' => '1','message' => sales_rep_routes_array}       
        else
          sales_rep_routes_array['name'] = emp.name
          # sales_rep_routes_array['phone_number'] = emp.phone

        response = {'success' => '0','message' => date1}

          response = {'success' => '0','message' => "#{'No Data Found '}#{Employee.date_formate1(date1).upcase}",'details' => sales_rep_routes_array}
        end
      else
        response = {'success' => '0','message' => 'Please Select SR'}

      end
      
    else
      response = {'success' => '0','message' => 'Required field missing'}
    end
    render :json => response
    
  end
  
  # ************************************  SALES REP DETAILS USER LOGIN   ************************************
  def get_employee_details
    code = params['code']
    date = params['date']
       
      if code.present? && date.present?         
            emolpyee_code = EmployeeAuthentication.find(:first , :conditions => {:code => code })
            if emolpyee_code.present?
              code = emolpyee_code.employee_code
                if(!Employee.code_check(code))
                    
                     employee = Employee.get_all_sales_rep_details_new(code,date)
                     response = {'success' => '1','message' => employee}
                   
                else
                      response = {'success' => '0','message' => 'Please Select SR'}
                end  
          else
             response = {"success" => 2, "message" => "logout"}
          end     
      else
        response = {'success' => '0','message' => 'Required field missing'}
      end  
        render :json => response
    
  end
  
   
   
    # ************************************  SALES REP DETAILS   ************************************
  def get_all_employee_details
       
     sales_rep_routes_array = Array.new  

     employee = Employee.find(:all)
     
     employee.each do |val|
       
         sales_rep_routes_hash = Hash.new  

        sales_rep_routes_hash['employee_code'] = val.employee_code
        sales_rep_routes_hash['employee_name'] = val.name
        sales_rep_routes_hash['s_code'] = val.supervisor_code
        sales_rep_routes_hash['company_code'] = val.company_code
       
        employee_role = EmployeeRole.find(val.role_id)
        sales_rep_routes_hash['role'] = employee_role.role
        

       
       sales_rep_routes_array << sales_rep_routes_hash
     end
      
     
        render :json => sales_rep_routes_array
             

  end
  
def index
    @fromtime=Time.new
    @from_time=@fromtime.strftime("%d %b, %Y")

     render :layout => false
 end  
    def get_allproducts
      total_products=SaleData.find_by_sql("SELECT DISTINCT
(a.product_code),b.product_name
FROM sale_data a, product_master b
WHERE a.product_code = b.product_code
AND b.product_code IS NOT NULL")
      response = {'success' => '1','message' => total_products}
      render :json => response
      end

    def get_allprincipals
      total_principals=SaleData.find_by_sql("SELECT DISTINCT
(d.principal_code),d.principal_name
FROM sale_data a, product_master b,brand_master c,principal_master d
WHERE a.product_code = b.product_code and b.brand=c.brand_code and c.principal=d.principal_code
AND d.principal_code IS NOT NULL")
      response = {'success' => '1','message' => total_principals}
      render :json => response
      end

    def get_allbrands
      total_brands=SaleData.find_by_sql("SELECT DISTINCT(c.brand_code),c.brand_name
FROM sale_data a, product_master b,brand_master c
WHERE a.product_code = b.product_code and b.brand=c.brand_code
AND c.brand_code IS NOT NULL")
      response = {'success' => '1','message' => total_brands}
      render :json => response
      end


      def get_allrsm
      total_rsm=SaleData.find_by_sql("SELECT DISTINCT (b.supervisor), c.sales_person_name
FROM sale_data a, sales_personnel b, sales_personnel c
WHERE a.salesperson_code = b.sales_person_code
AND b.supervisor IS NOT NULL
AND b.supervisor = c.sales_person_code")
      response = {'success' => '1','message' => total_rsm}
      render :json => response
      end

      def get_allsale_data
        @fromtime=Time.new
    @from_time=@fromtime.strftime("%Y-%m-%d")
        current_date_now=@from_time
        sale_data=SaleData.find_by_sql("SELECT GPS_latitude ,GPS_longitude FROM sale_data WHERE Date = '#{current_date_now}'
AND GPS_latitude IS NOT NULL AND GPS_longitude IS NOT NULL AND GPS_latitude !='' AND GPS_longitude != '' ")
          response = {'success' => '1','message' => sale_data}
      render :json => response
      end

      def get_total_sales
          @fromtime=Time.new
    @from_time=@fromtime.strftime("%Y-%m-%d")
        current_date_now=@from_time
         total_sale=SaleData.find_by_sql("SELECT  format(sum( total_values ),2) as total_values , format(sum(total_order ),2) as total_order , format(sum( line_item ),2) as line_item , format(avg( line_item ),2) as avg_line_item ,format(round(sum(total_values)/sum(total_order)),2)as drop_size
FROM sale_data WHERE Date =#{'current_date'}");
          response = {'success' => '1','message' => total_sale}
      render :json => response
      end
      def get_currendate
        @fromtime=Time.new
    from_time_new=@fromtime.strftime("%d %b, %Y")
     response = {'success' => '1','message' => from_time_new}
      render :json => response
      end
      def get_allsale_data_change
        from_date=params['from_date_format']
        to_date=params['to_date_format']
        rsm=params['rsm']
        product=params['product']
        brand=params['brand']
        principal=params['principal']
     if rsm.to_s=='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT GPS_latitude ,GPS_longitude FROM sale_data WHERE
GPS_latitude IS NOT NULL AND GPS_longitude IS NOT NULL AND GPS_latitude !='' AND GPS_longitude != '' AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif  rsm.to_s!='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b
WHERE a.supervisor = '#{rsm}'
AND a.sales_person_code = b.salesperson_code
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s=='0'
           sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b
WHERE b.product_code = '#{product}'
AND a.sales_person_code = b.salesperson_code
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

          

     elsif rsm.to_s=='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s=='0'

               sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s=='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b
WHERE b.product_code = '#{product}'
AND a.sales_person_code = b.salesperson_code
AND a.supervisor = '#{rsm}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND a.supervisor = '#{rsm}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s!='0'
        sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND a.supervisor = '#{rsm}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s!='0' and principal.to_s=='0'
         sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND b.product_code = '#{product}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")


     elsif rsm.to_s=='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s!='0'
          sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s!='0' and brand.to_s!='0' and principal.to_s=='0'
       sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND a.supervisor = '#{rsm}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND b.product_code = '#{product}'
AND a.supervisor = '#{rsm}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
     elsif rsm.to_s!='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND a.supervisor = '#{rsm}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s!='0' and principal.to_s!='0'

              sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     else
    sale_data=SaleData.find_by_sql("SELECT b.GPS_latitude, b.GPS_longitude FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND a.supervisor = '#{rsm}'
AND b.GPS_latitude IS NOT NULL
AND b.GPS_longitude IS NOT NULL
AND GPS_latitude !='' AND GPS_longitude != ''
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
     end
       
        sale_data_count=sale_data.count
        if sale_data_count.to_i > 0
          response = {'success' => '1','message' => sale_data}
        else
          response = {'success' => '0','message' => "#{'No Data Found Between'} #{from_date} #{'And'} #{to_date}"}
        end


      render :json => response
      end

     def get_total_sales_change
        from_date=params['from_date_format']
        to_date=params['to_date_format']
        rsm=params['rsm']
        product=params['product']
        brand=params['brand']
        principal=params['principal']
     if rsm.to_s=='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT  format(sum( total_values ),2) as total_values , format(sum(total_order ),2) as total_order , format(sum( line_item ),2) as line_item , format(avg( line_item ),2) as avg_line_item ,format(round(sum(total_values)/sum(total_order)),2)as drop_size
FROM sale_data where (Date BETWEEN '#{from_date}' AND '#{to_date}')")
        

     elsif  rsm.to_s!='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size
 FROM sales_personnel a, sale_data b
WHERE a.supervisor = '#{rsm}'
AND a.sales_person_code = b.salesperson_code
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s=='0'
           sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b
WHERE b.product_code = '#{product}'
AND a.sales_person_code = b.salesperson_code
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")



     elsif rsm.to_s=='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s=='0'

               sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s=='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b
WHERE b.product_code = '#{product}'
AND a.sales_person_code = b.salesperson_code
AND a.supervisor = '#{rsm}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s=='0'
        sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND a.supervisor = '#{rsm}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s=='0' and brand.to_s=='0' and principal.to_s!='0'
        sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND a.supervisor = '#{rsm}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s!='0' and principal.to_s=='0'
         sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND b.product_code = '#{product}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")


     elsif rsm.to_s=='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s!='0'
          sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s!='0' and brand.to_s!='0' and principal.to_s=='0'
       sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND a.supervisor = '#{rsm}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s!='0' and product.to_s!='0' and brand.to_s=='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND b.product_code = '#{product}'
AND a.supervisor = '#{rsm}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
     elsif rsm.to_s!='0' and product.to_s=='0' and brand.to_s!='0' and principal.to_s!='0'
       sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND a.supervisor = '#{rsm}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     elsif rsm.to_s=='0' and product.to_s!='0' and brand.to_s!='0' and principal.to_s!='0'

              sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values ,format( sum(b.total_order ),2)as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")

     else
    sale_data=SaleData.find_by_sql("SELECT  format(sum( b.total_values ),2) as total_values , format(sum(b.total_order ),2) as total_order , format(sum( b.line_item ),2) as line_item , format(avg( b.line_item ),2) as avg_line_item ,format(round(sum(b.total_values)/sum(b.total_order)),2)as drop_size FROM sales_personnel a, sale_data b,product_master c,brand_master d,principal_master e
WHERE a.sales_person_code = b.salesperson_code
AND b.product_code=c.product_code
AND c.brand=d.brand_code
AND d.principal=e.principal_code
AND d.principal='#{principal}'
AND c.brand='#{brand}'
AND b.product_code = '#{product}'
AND a.supervisor = '#{rsm}'
AND (Date BETWEEN '#{from_date}' AND '#{to_date}')")
            end
 sale_data_count=sale_data.count
        if sale_data_count.to_i > 0
          response = {'success' => '1','message' => sale_data}
        else
          response = {'success' => '0','message' => "#{'No Data Found Between'} #{from_date} #{'And'} #{to_date}"}
        end


      render :json => response
  
     end
     def get_company_name
       user_code=params['user_code']
     company_name=EmployeeAuthentication.find_by_sql("select c.company_name,c.company_code from  employee_authentications a,sales_personnel b, company_master c  where a.code='#{user_code}' and a.employee_code=b.sales_person_code and b.company_code=c.company_code")
     company_name.each do |comp|
       @companyname=comp.company_code
     end
        response = {'success' => '1','message' => @companyname}
       render :json => response
     end


#      principal value change function

     def get_principal_data_brand
       principal_value=params['principal']
       if principal_value.to_s!='0'
       brand_code=SaleData.find_by_sql("SELECT DISTINCT
(c.brand_code),c.brand_name
FROM sale_data a, product_master b,brand_master c,principal_master d
WHERE a.product_code = b.product_code and b.brand=c.brand_code and c.principal=d.principal_code
AND d.principal_code='#{principal_value}'");
       else
          brand_code=SaleData.find_by_sql("SELECT DISTINCT(c.brand_code),c.brand_name
FROM sale_data a, product_master b,brand_master c
WHERE a.product_code = b.product_code and b.brand=c.brand_code
AND c.brand_code IS NOT NULL")    
       end
       response = {'success' => '1','message' => brand_code}
      render :json => response
     end


     def get_principal_data_product
       principal_value=params['principal']
       if principal_value.to_s!='0'
       brand_code=SaleData.find_by_sql("SELECT DISTINCT
(b.product_code),b.product_name
FROM sale_data a, product_master b,brand_master c,principal_master d
WHERE a.product_code = b.product_code and b.brand=c.brand_code and c.principal=d.principal_code
AND d.principal_code='#{principal_value}'");
       else
          brand_code=SaleData.find_by_sql("SELECT DISTINCT(b.product_code),b.product_name
FROM sale_data a, product_master b,brand_master c
WHERE a.product_code = b.product_code and b.brand=c.brand_code
AND c.brand_code IS NOT NULL")
       end
       response = {'success' => '1','message' => brand_code}
      render :json => response
     end



     def get_brand_data_principal
      brand_value=params['brand']
       if brand_value.to_s!='0'
       brand_code=SaleData.find_by_sql("SELECT DISTINCT
(d.principal_code),d.principal_name
FROM sale_data a, product_master b,brand_master c,principal_master d
WHERE a.product_code = b.product_code and b.brand=c.brand_code and c.principal=d.principal_code
AND c.brand_code='#{brand_value}'");
       else
          brand_code=SaleData.find_by_sql("SELECT DISTINCT
(d.principal_code),d.principal_name
FROM sale_data a, product_master b,brand_master c,principal_master d
WHERE a.product_code = b.product_code and b.brand=c.brand_code and c.principal=d.principal_code
AND d.principal_code IS NOT NULL")
       end
       response = {'success' => '1','message' => brand_code}
      render :json => response
     end


     def get_brand_data_product
        brand_value=params['brand']
       if brand_value.to_s!='0'
       brand_code=SaleData.find_by_sql("SELECT DISTINCT(b.product_code),b.product_name
FROM sale_data a, product_master b,brand_master c
WHERE a.product_code = b.product_code and b.brand=c.brand_code
AND c.brand_code='#{brand_value}'");
       else
          brand_code=SaleData.find_by_sql("SELECT DISTINCT(b.product_code),b.product_name
FROM sale_data a, product_master b,brand_master c
WHERE a.product_code = b.product_code and b.brand=c.brand_code
AND c.brand_code IS NOT NULL")
       end
       response = {'success' => '1','message' => brand_code}
      render :json => response
     end


def get_product_data_principal
     product_value=params['product']
       if product_value.to_s!='0'
       brand_code=SaleData.find_by_sql("SELECT DISTINCT
(d.principal_code),d.principal_name
FROM sale_data a, product_master b,brand_master c,principal_master d
WHERE a.product_code = b.product_code and b.brand=c.brand_code and c.principal=d.principal_code
AND b.product_code='#{product_value}'");
       else
          brand_code=SaleData.find_by_sql("SELECT DISTINCT
(d.principal_code),d.principal_name
FROM sale_data a, product_master b,brand_master c,principal_master d
WHERE a.product_code = b.product_code and b.brand=c.brand_code and c.principal=d.principal_code
AND d.principal_code IS NOT NULL")
       end
       response = {'success' => '1','message' => brand_code}
      render :json => response
     end


     def get_product_data_brand
         product_value=params['product']
       if product_value.to_s!='0'
       brand_code=SaleData.find_by_sql("SELECT DISTINCT(c.brand_code),c.brand_name
FROM sale_data a, product_master b,brand_master c
WHERE a.product_code = b.product_code and b.brand=c.brand_code
AND b.product_code='#{product_value}'");
       else
          brand_code=SaleData.find_by_sql("SELECT DISTINCT(c.brand_code),c.brand_name
FROM sale_data a, product_master b,brand_master c
WHERE a.product_code = b.product_code and b.brand=c.brand_code
AND c.brand_code IS NOT NULL")
       end
       response = {'success' => '1','message' => brand_code}
      render :json => response
     end

end
