// FILTER ONCHANGE EVENT
function filter_change(name)
{
	
	
	// alert($("#"+name+"_picker").val());
	
	var val = $("#"+name+"_picker").val();
	
	if (val != 0)
	{		
		if (name != "company")
		{
			get_employee_details_tree_view(val,1);
		}
	}
	else
	{
		split_tree_details();
	}

				
}


function split_tree_details_onchange()
{
		// var arr = ['gm_picker','nsm_picker','rsm_picker','asm_picker','sr_picker']
		
// 		Company details
		
	   show_brand(Show_company_emp_details1);
	   		
		for (var j=0; j< Show_higher_emp_details1.length;j++)
	   	{
	   		show_brand(Show_higher_emp_details1[j]);
	   	}	
	   		
		// alert(JSON.stringify(Show_all_emp_details1.length)+" hfidhjg  "+JSON.stringify(Show_higher_emp_details1)+" kjhdfjhg  "+JSON.stringify(Show_company_emp_details1));
	
		for (var i=1;i<Show_all_emp_details1.length;i++)
	   		{
	   			// for (var j=0;j<Show_all_emp_details[i].length;j++)
			   		// {
			   			show_brand_picker(Show_all_emp_details1[i],1,0);
			   		// }
	   		}
	   		
	   		var sr_details = $("#sr_picker").val();
	   		
	   		if (sr_details != 0)
	   		{
	   			get_sales_rep_details(sr_details,0);
	   		}
	   		
	   		
	   		
}


function split_tree_details()
{
		// var arr = ['gm_picker','nsm_picker','rsm_picker','asm_picker','sr_picker']
		
// 		Company details

		// alert(Show_company_emp_details.length);
		if (Show_company_emp_details.length == 1)
		{
	   		show_brand_picker(Show_company_emp_details,0,1);
		}
		else if(Show_company_emp_details.length > 1)
		{
	   		show_brand_picker(Show_company_emp_details,1,1);
		}
	   
	   
	   for (var i=0;i<Show_all_emp_details.length;i++)
	   		{
	   			// for (var j=0;j<Show_all_emp_details[i].length;j++)
			   		// {
			   			show_brand_picker(Show_all_emp_details[i],i,1);
			   		// }
	   		}
	   		
	   
		for (var j=0; j< Show_higher_emp_details.length;j++)
	   	{
	   		show_brand_picker(Show_higher_emp_details[j],0,1);
	   	}		
		
		
}




function show_brand_picker(brand_dropdown,i,req){
	
		// alert(brand_dropdown);
		var store_id;
		var select_disable = true;

			var selectHTML ="";
					for(kl=0;kl<brand_dropdown.length;kl++)
					{
						if (kl == 0 && (i != 0 || brand_dropdown.length > 1))
						{
							
							selectHTML+= "<option value='0'>All</option>";
							select_disable = false;
							

						}
						
						        selectHTML+= "<option value='"+brand_dropdown[kl]["employee_code"]+"'>"+brand_dropdown[kl]["employee_name"]+"</option>";
								store_id = brand_dropdown[kl]["role"];
					}	
					
					
					jQuery.fn.exists = function(){return this.length>0;}

						if ($("#"+store_id.toLowerCase()+"_picker").exists()) {
						    // Do something
						
							    var div = document.getElementById(store_id.toLowerCase()+"_picker");
								while(div.firstChild){
		    					div.removeChild(div.firstChild);
								}
					        	document.getElementById(store_id.toLowerCase()+"_picker").innerHTML= selectHTML;
								// alert(selectHTML);						        
						        
						    } else {
						        // alert('false');
						    }
					 
					        
					        if (i == 0 && select_disable && req == 1)
					        {
					        	if (brand_dropdown.length >= 1)
					        	{
					        			
					        	$("#"+store_id.toLowerCase()+"_picker").prop("disabled", true);
								$("."+store_id.toLowerCase()+"_").addClass('filter_t12');
								$("."+store_id.toLowerCase()+"_ div").addClass('filter_type1');
					        	}
					        	
					        
					        }
					        else{
					        	$("."+store_id.toLowerCase()+"_").removeClass('filter_t12');
								$("."+store_id.toLowerCase()+"_ div").removeClass('filter_type1');
					        	}			
		}
		
		
		function show_brand(brand_dropdown){
	
		// alert(brand_dropdown);
		var store_id;

						// alert(brand_dropdown);

					for(kl=0;kl<brand_dropdown.length;kl++)
					{				
						store_id = brand_dropdown[kl]["role"];
			
						// alert("jjbb  "+brand_dropdown[kl]["employee_code"]);
						// alert(brand_dropdown[kl]["employee_code"]+"    &&     "+brand_dropdown[kl]["role"]);
							$("#"+store_id.toLowerCase()+"_picker").val(brand_dropdown[kl]["employee_code"]);
					}	
		}
		
	
	// When logout window to call this method	
	function clear_dropdown()
		{
//				var arr = ['company_','gm_','nsm_','rsm_','asm_','sr_']
//				for (var i=0;i<arr.length;i++)
//	   			{
//	   					$("#"+arr[i]+"picker").prop("disabled", false);
//						$(".filter_t").addClass('filter_t12');
//						$(".filter_t div").addClass('filter_type1');
//						var div = document.getElementById(arr[i]+"picker");
//							while(div.firstChild){
//	    					div.removeChild(div.firstChild);
//							}
//	   			}
//$('#logout').trigger("click");
	   		
		}
		
		
		function employee_filter_kd()
		{
			var employee_role = sessionStorage['emp_role'];
			var arr = ['company_','gm_','nsm_','rsm_','asm_']
				
			
			if (sessionStorage['emp_role'] == "KD")
			{
				for (var i=0;i<arr.length;i++)
	   			{
	   					$("."+arr[i]).hide();
	   					$(".kd_").show();
						
	   			}
			}
			else
			{
				for (var i=0;i<arr.length;i++)
	   			{
	   					$("."+arr[i]).show();
	   					$(".kd_").hide();
						
	   			}
			}
		}
		
		
		
		function admin_check()
		{
			// alert(sessionStorage['emp_role']);
			if (sessionStorage['emp_role'] == "ADMIN")
			{
				$('.admin').show();						
			}
			else{
				$('.admin').hide();						
			}
		}

function load_all_data()
  {
$('#loading_data').show();
        $.ajax({

          url : "/employees/get_currendate",
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];

            if(success == "1")
            {

              $("#from_date").val(data['message']);
              $("#to_date").val(data['message']);


              $("#from_date").datepicker({

                dateFormat: 'dd M, yy' // this is the format of the date that will be shown


              });
              $("#to_date").datepicker({
                dateFormat: 'dd M, yy' // this is the format of the date that will be shown

              });

            }

          }
        });

        //all products
        $.ajax({
          url : "/employees/get_allproducts",
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];

            if(success == "1")
            {
              var product_array=data['message'];

              var all_products=data['message'].length;
              if (all_products > 0)
              {
                // alert(JSON.stringify(data['message']));

                $('#product').empty().append($('<option>', {
                  value: "0",
                  text : "ALL"
                }));
                $.each(product_array, function (i, item) {

                  $('#product').append($('<option>', {
                    value: item.product_code,
                    text : item.product_name
                  }));
                });

              }
              else
              {
                $('#product option[value!="0"]').remove();

              }


            }

          }
        });

        //all brands
        $.ajax({
          url : "/employees/get_allbrands",
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];

            if(success == "1")
            {
              var brand_array=data['message'];

              var all_brands=data['message'].length;
              
              if (all_brands > 0)
              {
                // alert(JSON.stringify(data['message']));

                $('#brand').empty().append($('<option>', {
                  value: "0",
                  text : "ALL"
                }));
                $.each(brand_array, function (i, item) {

                  $('#brand').append($('<option>', {
                    value: item.brand_code,
                    text : item.brand_name
                  }));
                });

              }
              else
              {
                $('#brand option[value!="0"]').remove();

              }


            }

          }
        });


        //allprincipal
        $.ajax({
          url : "/employees/get_allprincipals",
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];

            if(success == "1")
            {
              var principal_array=data['message'];

              var all_principals=data['message'].length;
              if (all_principals > 0)
              {
                // alert(JSON.stringify(data['message']));

                $('#principal').empty().append($('<option>', {
                  value: "0",
                  text : "ALL"
                }));
                $.each(principal_array, function (i, item) {

                  $('#principal').append($('<option>', {
                    value: item.principal_code,
                    text : item.principal_name
                  }));
                });

              }
              else
              {
                $('#principal option[value!="0"]').remove();

              }


            }

          }
        });


        //all rsm
        $.ajax({
          url : "/employees/get_allrsm",
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];

            if(success == "1")
            {
              var rsm_array=data['message'];

              var all_rsm=data['message'].length;
              if (all_rsm > 0)
              {
                // alert(JSON.stringify(data['message']));

                $('#rsm').empty().append($('<option>', {
                  value: "0",
                  text : "ALL"
                }));
                $.each(rsm_array, function (i, item) {

                  $('#rsm').append($('<option>', {
                    value: item.supervisor,
                    text : item.sales_person_name
                  }));
                });


              }
              else
              {
                $('#rsm option[value!="0"]').remove();

              }


            }

          }
        });


        //map to plot current date sale data
        $.ajax({
          url : "/employees/get_allsale_data",
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];
            //

            if(success == "1")
            {
              //alert("hiiiiiiiiiiiiiiiiiii")
              var alldata=data['message'];
             // alert(JSON.stringify(data['message']));
             show_cluster(alldata);
            //show_map_all_data(alldata);
            }
            else
            {
              //alert(data['message']);
              init_map();

            }


          }


        });



        //total sales
        //map to plot current date sale data
        $.ajax({
          url : "/employees/get_total_sales",
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

              var locations=[];
              var _len = alldata.length;
              var post=[];
              var i;

              for (i = 0; i < _len; i++) {

                post = alldata[i];
                var total_values=post.total_values;
                var total_order=post.total_order
                var line_item=post.line_item
                var avg_line_item=post.avg_line_item
                var drop_size=post.drop_size

              }

              $("#total_sales").val(total_values);
              $("#total_orders").val(total_order);
              $("#total_line_item").val(line_item);
              $("#avg_line_item").val(avg_line_item);
              $("#drop_size").val(drop_size);
            }
            else
            {

              $("#total_sales").val()="";
              $("#total_orders").val()="";
              $("#total_line_item").val()="";
              $("#avg_line_item").val()="";
              $("#drop_size").val()="";

            }


          }


        });
        //

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
             $('#loading_data').hide();
            }
            else
            {


            }


          }


        });





 }
      function from_date_show(from_date_pass,to_date_pass)
      {
$('#loading_data').show();
        var enddate=$.datepicker.formatDate('dd-mm-yy', new Date($("#to_date").val()));
	var enddateval = enddate.substring(6,10)+"/"+enddate.substring(3,5)+"/"+enddate.substring(0,2);
	var current_date=$.datepicker.formatDate('dd-mm-yy', new Date($("#from_date").val()));
	var current_dateval = current_date.substring(6,10)+"/"+current_date.substring(3,5)+"/"+current_date.substring(0,2);

	var date_check=new Date(enddateval).getTime() >= new Date(current_dateval).getTime();
	if (date_check==false)
	{
          alert("To date Should Be Greater or Equal to From Date");
          return false;
        }

        else
        {



        if((typeof(from_date_pass)  === "undefined")||(from_date_pass == ""))
        {
        var from_date = $("#from_date").val();
        }

       else
        {
         var from_date = from_date_pass;
         $("#from_date").val(from_date_pass);
       }


        if((typeof(to_date_pass)  === "undefined")||(to_date_pass == ""))
        {
        var to_date = $("#to_date").val();
        }

       else
        {
         var to_date = to_date_pass;
         $("#to_date").val(to_date_pass);
       }




        var from_date_format = $.datepicker.formatDate('yy-mm-dd', new Date(from_date));
        var to_date_format = $.datepicker.formatDate('yy-mm-dd', new Date(to_date));



        var rsm= $("#rsm").val();
        var product=$("#product").val();
        var brand=$("#brand").val();
        var principal=$("#principal").val();

        var params ={'from_date_format' : from_date_format,'to_date_format' : to_date_format,'rsm' : rsm,'principal' : principal,'brand' : brand,'product' : product};

        $.ajax({
          url : "/employees/get_allsale_data_change",
          data : params,
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
//alert(JSON.stringify(data['message']));
              //show_map_all_data(alldata);
               show_cluster(alldata);
            }
            else
            {
                $('#loading_data').hide();
              alert(data['message']);
              init_map();

            }
$('#loading_data').hide();

          }


        });



        $.ajax({
          url : "/employees/get_total_sales_change",
          data : params,
          type : "POST",
          error : function(error) {
            hideLoader('fail', 'Sorry Server down,\n Please try again later', '');

          },
          success : function(data) {
            var success = data['success'];

            if(success == "1")
            {
              var alldata=data['message'];

              var locations=[];
              var _len = alldata.length;
              var post=[];
              var i;
              for (i = 0; i < _len; i++) {

                post = alldata[i];
                var total_values=post.total_values;
                var total_order=post.total_order
                var line_item=post.line_item
                var avg_line_item=post.avg_line_item
                var drop_size=post.drop_size

              }

              $("#total_sales").val(total_values);
              $("#total_orders").val(total_order);
              $("#total_line_item").val(line_item);
              $("#avg_line_item").val(avg_line_item);
              $("#drop_size").val(drop_size);
            }
            else
            {

              $("#total_sales").val()="";
              $("#total_orders").val()="";
              $("#total_line_item").val()="";
              $("#avg_line_item").val()="";
              $("#drop_size").val()="";

            }


          }


        });

          }


      }

