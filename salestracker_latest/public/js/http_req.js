var Sales_rep_last_date ="";
   // ************************************  ALL SALES MAN AJAX REQUEST   ************************************
	function get_all_sales_rep()
		{
//			var role = 5;
//
//    		var date1 = $("#date").val();
//			// alert(date);
//    		// var date = '2013-07-05';
//    		var params ={'date' : date1 };
//    		// alert(JSON.stringify(params));
//			$.ajax({
//					url : "/employees/get_all_sales_rep",
//					data : params,
//					type : "POST",
//					error : function(error) {
//						hideLoader('fail', 'Sorry Server down,\n Please try again later', '');
//
//					},
//					success : function(data) {
//						var success = data['success'];
//
//						if(success == "1")
//						{
//
//							$('.classname').trigger('click');
//
//
//							if($("#sr_picker").val() !=0)
//							{
//								get_sales_rep_details($("#sr_picker").val(),0);
//							}
//
//							// arr_name = [];
//							// id1 = [];
//							// var div = document.getElementById('emp_list1');
//							// while(div.firstChild){
//	    					// div.removeChild(div.firstChild);
//							// }
//							// var msg = data['message'];
//							// createList(msg);
//							// alert(JSON.stringify(data['message']));
//
//						}
//						else
//						{
//							alert(data['message']);
//						}
//					}
//				});
		}
	
   // ************************************  PARTICULAR SALES REP DETAILS   ************************************
	function get_sales_rep_details(employee_code,req)
		{
			var date1 = $("#date").val();
    		var date = $.datepicker.formatDate('yy-mm-dd', new Date(date1));
			var params = ""	,url1= "";
					
			if (req == 1)
			{
    			 params ={'id': employee_code};
    			 url1= "actual_routes/last_viewed_location";
			}
			else
			{
    			 params ={'id': employee_code,'date':date};
    			 url1= "/employees/get_sales_rep_details";
			}
			$.ajax({
					url : url1,
					data : params,
					type : "POST",
					error : function(error) {
						hideLoader('fail', 'Sorry Server down,\n Please try again later', '');
						
					},
					success : function(data) {
						var success = data['success'];
						
						if(success == "1")
						{

							clear_all_item();
							var msg = data['message'];
							var planned_path = data['message']['planned_path'];
							var actual_path = data['message']['actual_path'];
							show_details_sr_name = data['message']['name'];
	  						show_details_sr_phone = data['message']['phone_number'];
							// lat_lng_address = data['message']['planned_path']['customer'];
							// alert(JSON.stringify(actual_path));
							// alert(JSON.stringify(planned_path));
							actual_path_date = msg;
							show_map(planned_path,actual_path);
							
							get_address_details(actual_path);
							hour_pin_display(data);
							
							lat_lng_seq(data['message']['planned_path']);

							// alert(data['message']['date']);
							if (req == 1)
							{
								var response_date = data['message']['date'];
			 					$('#date').datepicker('setDate',new Date(response_date));
								
							}
							
							Sales_rep_last_date = data['message']['last_record'];
							// alert(data['message']['last_record']);
							// var intervel1=self.setInterval(function(){
// 								
									// $('#tm9_00').trigger('click');
									// clearInterval(intervel1);
									// show_planned();
// 
// 
							// },2500);


						}
						else
						{
							clear_all_item();
							init_map();

							alert(data['message']);
							show_details_sr_name = data['details']['name'];
	  						show_details_sr_phone = data['details']['phone_number'];
							show_planned();
						}
					}
				});
		}
		
		function clear_all_item()
		{
			document.getElementById("planned_checked").checked = false;
							seq= [];
							lat__=[];
							lng__=[];
							null_polyline();
							actual_path_marker = [];
							planned_latlong =[];
							actual_latlong =[];
							hour_click_lat_lng = [];
							planned_customer_name = [];
							planned_customer_phone_number = [];
	  						hour_click_hour = [];
	  						lat_lng_address = [];
	  						show_details_sr_name ="";
	  						show_details_sr_phone ="";
	  						lat_lng_address_actual =[];
	  						document.getElementById('time').value = "9:00am";

		}
   // ************************************  Login authentication   ************************************
	
	function login_authentication(username,password)
	{
		
		
			var params ={'user_code' : username,'password' : password};
		
			// alert(JSON.stringify(params)+"  "+get_url);
		$.ajax({
			url : "employee_authentications/login_user",
			data : params,
			type : "post",
			error : function(error) {
				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					var session_check = "1";
					// alert(JSON.stringify(data['message']['user_name']));
					
					
						sessionStorage['user_name'] = data['message']['user_name'];
						sessionStorage['user_code'] = data['message']['user_code'];
						sessionStorage['emp_role'] = data['message']['emp_role'];
                                                sessionStorage['user_role'] = data['message']['user_role'];
						sessionStorage['user_role'] = data['message']['user_role']+"("+data['message']['user_branch']+")";
						sessionStorage['session_check'] = session_check;
						
						
						if ( sessionStorage['user_name'] == 'undefined')
						{
							$('#manager_name').hide();
							$('#post_').hide();
						}
						else
						{
							$('#manager_name').show();
							$('#post_').show();
							
						}

						
						$('#usr_name').val("");
 						$('#password').val("");
                                                //$('#company_user').val()=data['message']['emp_role'];
                                           
                                                      
						$('#manager_name').text(""+sessionStorage['user_name']);
						$('#post_').text(""+sessionStorage['user_role']);
						 // get_all_sales_rep();
						 
						 if (sessionStorage['emp_role'] != 'ADMIN')
						 {
						  get_employee_details_tree_view("",0);
						 }

							
									$('.login').hide();
                                                                        
                                                                       if (sessionStorage['emp_role'] != 'ADMIN')
						 {
                                                     load_all_data();
                                                    }
									
												employee_filter_kd();
												admin_check();
						//

                                               //login page after check from data

                             
                                           // location.reload();

                                           //reload full _data
                                                var user_code=sessionStorage['user_code'];
        var params_code ={'user_code' : user_code};



        $.ajax({
          url : "/employees/get_company_name",
          data : params_code,
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];
            // alert(JSON.stringify(data['message']['user_name']));

            if(success == "1")
            {
              var alldata=data['message'];

              $("#company_user").val(data['message']);
            }
            else
            {


            }


          }


        });

					//alert(JSON.stringify(data['message']));
				}
				else
				{
					alert(data['message']);
				}
			}
		});
		
	}
	
   // ************************************  Login authentication   ************************************
	function get_employee_details_tree_view(code,req)
	{		
//		var params,url;
//
//		if (req == 1)
//		{
//			params ={'code': code};
//			url = "temp_emp_trees/temp_table1";
//		}
//		else{
//			 params ={'code': sessionStorage['user_code']};
//			 url = "temp_emp_trees/temp_table";
//		}
//
//
//			$.ajax({
//					url : url,
//					data : params,
//					type : "POST",
//					error : function(error) {
//						// hideLoader('fail', 'Sorry Server down,\n Please try again later', '');
//						alert(JSON.stringify(error));
//					},
//					success : function(data) {
//						var success = data['success'];
//
//						if(success == "1")
//						{
//							// alert(JSON.stringify(data));
//							if (req != 1)
//							{
//																// alert(JSON.stringify(data['company_details']));
//
//								Show_all_emp_details = [];
//								Show_higher_emp_details = [];
//								Show_company_emp_details = [];
//								Show_all_emp_details = data['message'];
//								Show_higher_emp_details = data['high_post']
//								Show_company_emp_details = data['company_details']
//								// create_new_List();
//								split_tree_details();
//
//							}
//							else
//							{
//																								// alert(JSON.stringify(data['message']));
//
//								Show_all_emp_details1 = [];
//								Show_higher_emp_details1 = [];
//								Show_company_emp_details1 = [];
//								Show_all_emp_details1 = data['message'];
//								Show_higher_emp_details1 = data['high_post']
//								Show_company_emp_details1 = data['company_details']
//
//								split_tree_details_onchange();
//
//
//							}
//							// alert(JSON.stringify(data['message']));
//						}
//						else
//						{
//							alert(data['message']);
//						}
//					}
//				});
	}


 // ************************************  Login authentication   ************************************
	function get_employee_details_tree_view1(code,req)
	{
		var params;
		
		if (req == 1)
		{
			params ={'code': code,'role' : sessionStorage['emp_role']};
		}
		else{
			params ={'code': code,'role' : sessionStorage['emp_role']};
		}
		
			$.ajax({
					url : "temp_emp_trees/temp_table1",
					data : params,
					type : "POST",
					error : function(error) {
						hideLoader('fail', 'Sorry Server down,\n Please try again later', '');
					},
					success : function(data) {
						var success = data['success'];
						
						if(success == "1")
						{
							alert(JSON.stringify(data['message']));
						}
						else
						{
							alert(data['message']);
						}
					}
				});
	}



// 	 Adminn create new User 

	function admin_create_new_employee(employee_code,employee_name,employee_password,employee_role,req)
	{
		var params;
		
		if (req == 1)
		{
			 params ={'user_code' : employee_code};
		}
		else if (req == 2)
		{
			 params ={'user_code' : employee_code,'password' : employee_password,'role' : employee_role,'name' : employee_name};
		}
		
			// alert(JSON.stringify(params));
		$.ajax({
			url : "employee_authentications/create_new_user",
			data : params,
			type : "post",
			error : function(error) {
				alert(JSON.stringify(error))
			},
			success : function(data) {
				var success = data['success'];
				
				if(success == "1")
				{
					
					employee_code_focus_out(data['message']['name'],data['message']['role'],data['message']['desg']);
					
				}
				else if (success == "2")
				{
					alert(data['message']);
					employee_code_focus_out("","","");					
					// $('#employee_name').val("");
					$('#employee_code').val("");
					$('#employee_password').val("");
					$('#employee_confirm_pwd').val("");
					// $('.employee_role').val("");
					// $('#desgination').val("");
				}
				else
				{
					alert(data['message']);
				}
			}
		});
	}


	


   