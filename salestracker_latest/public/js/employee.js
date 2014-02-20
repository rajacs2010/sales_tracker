var map;
var actual_path_date;
var hour_click_lat_lng = [],hour_click_hour = [],hour_marker_arr = [],actual_path_marker = [];
var planned_latlong =[];
var actual_latlong =[];
var hour_marker;
var arr_name = [];
var id1 = [];
var intervel;
var seq= [],lat__=[],lng__=[];
var planned_polyline,actual_polyline;
 var lat_lng_address =[],show_address_id=[];
 var Show_all_emp_details = [],Show_higher_emp_details = [],Show_company_emp_details = [];
 var Show_all_emp_details1 = [],Show_higher_emp_details1 = [],Show_company_emp_details1 = [];
 



   // ************************************  DEVICE DEADY   ************************************
$(document).ready(function(){
	
	var session_check = sessionStorage['session_check'];	
	if (session_check == "1")
	{
		$('.login').hide();
		
		if (sessionStorage['emp_role'] != 'ADMIN')
		{
			get_employee_details_tree_view("",0);
		}	 
		// alert(""+sessionStorage['user_name']);
		$('#manager_name').text(""+sessionStorage['user_name']);
		$('#post_').text(""+sessionStorage['user_role']);
		admin_check();
		employee_filter_kd();
		
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

	}
	
        $('#date').datepicker({ dateFormat: 'dd M, yy' ,
        onSelect: function(dateText) {
    				// alert(dateText);
    		get_all_sales_rep();
    		
    		// if ($("#sr_picker").val() !=0)
				// {
	   				// get_sales_rep_details($("#sr_picker").val(),0);
				// }
				// else
				
    		
    		init_map();

  				}});
  			
  		$('#time').timepicker({
  			'minTime': '9:00am',
			'maxTime': '8:00pm'
  		});
  		
  			
  		$('#calendar-icon').click(function(){
			 $('#date').datepicker('show');
		});
		
  		$('#calendar-icon1').click(function(){
			 $('#time').timepicker('show');
		});
  				
  		$('#date_now').click(function(){
			 $('#date').datepicker('setDate',new Date());
			 
			 var is_show= true;
				$('.classname').each(function() {
					is_show = false;
					var id2__ = (this.id).split("_");    			
    				get_sales_rep_details(id2__[1],0);
    			
				});
				
				if (is_show)
				{
	   				get_sales_rep_details($("#sr_picker").val(),0);
				}
			});
  				
  		$('#time_now').click(function(){
			// $('#time').timepicker('setTime', new Date());
			 var is_show= true;
			$('.classname').each(function() {
					is_show = false;
			var id2__ = (this.id).split("_");    			
    			get_sales_rep_details(id2__[1],1);
    			
			});
			if (is_show)
				{
	   				get_sales_rep_details($("#sr_picker").val(),1);
				}
			// get_sales_rep_details
		});
  				
  		
//   		Show all tree details	
		
  				var prettyDate;
        var date__ = $.datepicker.formatDate('dd M, yy', new Date());
        // $.validator.methods["date123"] = function (value, element) { return true; }
//         
		// var date__ = "06 Jul, 2013";
		
		document.getElementById('date').value = date__;
		document.getElementById('time').value = "9:00am";
		
		
          // get_all_sales_rep();
          
           $('#date').click(function(){
           		 $('#date').blur();
           });
				init_map();
		
		
    
      // WINDOW RESIZE FUNCTION 
     $(window).resize(function(){
        // $("#map_canvas").height($(document).height());
            resizeContainers();

    });
    
    // show_map();
    allsearch();

    resizeContainers();
    // show_bottom_div();
	show_bottom_div_new();       
        		
 	
// 	LOGIN ONCLICK EVENT 
 	$('#login_button').click(function(){
 		
 		var user_name = $('#usr_name').val();
 		var password = $('#password').val();
 		
 		if(user_name != "" && password != "")
 		{
 			login_authentication(user_name,password);
 			
 		}
		else
		{
			 	alert("Pleas Enter User name & Password");
		}
 	});
	
	 $("#logout").click(function()
		{
			sessionStorage['user_name'] = "";
			sessionStorage['user_code'] = "";
			sessionStorage['user_role'] = "";
			sessionStorage['emp_role'] = "";
			sessionStorage['session_check'] = "0";
			$('#manager_name').text("");
			$('#post_').text("");			
			var date__ = $.datepicker.formatDate('dd M, yy', new Date());
			document.getElementById('date').value = date__;
						var div = document.getElementById('emp_list1');
							while(div.firstChild){
	    					div.removeChild(div.firstChild);
							}
							var div = document.getElementById('emp_list');
							while(div.firstChild){
	    					div.removeChild(div.firstChild);
							}
						init_map();
			// filter dropdown clear
			clear_dropdown();
			$('.login').show();
			employee_filter_kd();
			admin_check();

			
		});
		
		$(".legend").click(function()
		{
			if ($(".show_details").is(":visible"))
			{
				$(".show_details").hide();
			}
			else
			{
				$(".show_details").show();
			}
		});
		
	
        user_authentication();
}); 


	function show_bottom_div_new()
	{
		var show_time_id =[] ;		
		 $('#time').on('changeTime', function() {
				// alert($(this).val());
          var id2 = $(this).val();
         
				 // // Clear pin 
          if (hour_marker !=null)
				{
					hour_marker.setMap(null);   
				}
			var n = 0;	
		  clearOverlays();

	
          for (var i in hour_click_hour)
          {
			
			
			var id2__ = id2.split(":");
			var id2_min = id2__[1].substring(0,2);
			if(id2__[1].substring(2,4) == "pm")
			{
				id2__[0] = parseInt(id2__[0]) + 12;
			}
			

			var id21__ =  id2__[0]+":"+(parseInt(id2_min));
          	
          	var id2_min_con = id2__[0]+":"+(parseInt(id2_min)+29);

          	          // alert(id2__+"    "+hour_click_hour[i]);

          	if (hour_click_hour[i] == id21__ ||(hour_click_hour[i] >= id21__ && hour_click_hour[i] <= id2_min_con) )
          	{
          		

          		show_address_id[n] = i;
          		show_time_id[n] = hour_click_hour[i];          		
          		hour_marker_arr[n] = new google.maps.Marker({
			    position: hour_click_lat_lng[i],
			    title: ""+hour_click_lat_lng[i],
			    draggable:false,
			    animation: google.maps.Animation.DROP
			    
				});
				n++;
				
          	}
          	else
          	{
          		// if (hour_marker !=null)
				// {
					// hour_marker.setMap(null);   
				// }
          	}
          }
          

          for (var i in hour_marker_arr)
          {
          	    hour_marker_arr[i].setMap(map);
          	    show_address(hour_marker_arr[i],show_address_id[i],show_time_id[i]);
          	  // show_map_infowindow(hour_marker_arr[i],show_address_id[i]);
          }		
          
				
				
				
				
		});
  			
	}

	
// 	show address details using latitude & longitude
	function show_address(hour_marker_arr_val,i,time)

	{
		 var infowindow;
  			var geocoder = new google.maps.Geocoder();
		 
  			google.maps.event.addListener(hour_marker_arr_val, 'click', function(event) {
  				var on_click_lat_long= this;
				var lat_long_gmap = event.latLng;
				closeAllInfoWindow();
				// "lat  : "+lat_long_gmap.lat()+"</br>  lng : "+lat_long_gmap.lng()
		 		 var latlng = new google.maps.LatLng(parseFloat(lat_long_gmap.lat()), parseFloat(lat_long_gmap.lng()));
  				
  				// alert(parseFloat(lat_long_gmap.lng()));
  				
  				if (infowindow != null)
					{
							infowindow.open(null,null);
							// alert(hour_marker_arr[i]);
					}
				
				
				
				try{
					geocoder.geocode({'latLng': latlng}, function(results, status) {
				
				if (status == google.maps.GeocoderStatus.OK) {
				    	
				      if (results[1]) {
				        // alert(results[1].formatted_address);
				      // return results[1].formatted_address;
				      infowindow = new google.maps.InfoWindow({
    						content: '<div class=show_message_gmap>Address  :   '+results[1].formatted_address+'</br> Time   :    '+time+'</div>'

							});
    					infowindow.open(map,on_click_lat_long);
				      } else {
				      					        // alert("23");
							infowindow = new google.maps.InfoWindow({
    						content: '<div class=show_message_gmap>lat : '+lat+'</br>lng : '+lng+'</br> Time   :    '+time+'</div>'

							});
    					infowindow.open(map,on_click_lat_long);					
				      }
				    } else {
				        // alert("d");
							infowindow = new google.maps.InfoWindow({
    						content: '<div class=show_message_gmap>lat : '+lat+'</br>lng : '+lng+'</br> Time  :    '+time+'</div>'

							});
    					infowindow.open(map,on_click_lat_long);						
				    }
			});
				  
				   
			}
			catch(e)
			{
				alert(e);
			}
					
  			});
  
	}

  
   // ************************************  SCREEN SIZE   ************************************
	function resizeContainers() {
			var $window = $(window);
	
			var wWidth  = $window.width();
			var wHeight = $window.height();
	    $(".left_div").css("width", (wWidth*78/100) + "px");
	    $(".left_div").css("height", (wHeight*100/100) + "px");
	    $("#map_canvas").css("width", (wWidth*78/100) + "px");
	    $(".user_area").css("width", (wWidth*22/100) + "px");
	    $("#map_canvas").css("height", (wHeight*100/100) + "px");
	    $(".user_area").css("height", (wHeight*16/100) + "px");
	    $(".employee_list").css("width", (wWidth*22/100) + "px");
	    $(".employee_list").css("height", (wHeight*85/100) + "px");
	    $(".right_div").css("height", (wHeight*100/100) + "px");
	    $(".right_div").css("width", (wWidth*22/100) + "px");
	    $(".bottom_div").css("height", (wHeight*5/100) + "px");
	    $(".bottom_div").css("width", (wWidth*80/100) + "px");
	    $(".emp_search").css("height", (wHeight*5/100) + "px");
	    $(".emp_search").css("width", (wWidth*22/100) + "px");
	 	 // $(".show_details").css("height", (wHeight*8/100) + "px");
	    // $(".show_details").css("width", (wWidth*22/100) + "px");
	}
	
	function lat_lng_seq(msg)
	{
		seq= [];
		lat__=[];
		lng__=[];
		
		
		for (var i in msg)
		{
			seq[i] = msg[i]['seq'];
			lat__[i] = msg[i]['lat'];
			lng__[i] = msg[i]['lng'];
		}
		
	}		
		
   // ************************************  SHOW LIST OF SALES REP   ************************************
   function createList(msg)
   {
	        // var arr = ['list','jbjcfd','yufftyysfyf'];
	        // var id1 = ['1','2','3'];
		
	   	for (var j in msg)
	   	{
	   		var employee_code = msg[j]['employee_code'];
	   		var name1 = msg[j]['name'];
	   		if (j==0)
	   		{
	   			get_sales_rep_details(employee_code,0);
	   		}

	   		arr_name[j] = name1;
	   		id1[j] = employee_code;
	   	}
 	        
			init_map();
			show_name_list(arr_name,id1);

    }
    
       // // ************************************  SHOW LIST OF SALES REP   ************************************
    // function show_name_list(arr,id12)
    // {
    	// $(".emp_list").append("<ul></ul>");
			// for(var i in arr) {
			  // if (i==0) {
			  	// // alert("dd");
			        // var li = "<li id="+id12[i]+" onclick=show("+id12[i]+") class=classname><img onmouseover=show_list() onmouseout=hide_list() src=/images/name_marker.png class=name_marker>";
// 
			  // }
			  // else
			  // {
			  	// // alert("dd1");
// 
			    // var li = "<li id="+id12[i]+" onclick=show("+id12[i]+")><img onmouseover=show_list() onmouseout=hide_list() src=/images/name_marker.png class=name_marker>";
			  // }
			      // $(".emp_list ul").append(li.concat(arr[i]))
			     	// $('#'+id12[0]+' img').show();
// 
			// }
// 			
// 			
    // }
//     
    // function show_sub_name_list()
	// {
// 		
	// }
    
     // ************************************  HOVER SHOW ACTUAL PATH DETAILS ************************************
      function show_list()
      {
      	if ($('.show_planned_path_details').is(":visible"))
      	{
      		hide_list();
      	}
      	else
      	{
      		      	$('.show_planned_path_details').show();
      		      	      				show_planned();

      	}
      }
    // ************************************  HOVER HIDE   ************************************
       function hide_list()
      {
      	$('.show_planned_path_details').hide();
      }
      
   // ************************************  PARTICULAR SALES REP CLICK DETAILS   ************************************
	function show(clicked_id)
	 {
 			$('.name_marker').hide();
          $('.classname').removeClass('classname');
          // var id1 = $(this).attr('id');
          // alert(clicked_id);
          document.getElementById(clicked_id).className ='classname';
          $('#'+clicked_id+' img').show();	   

          get_sales_rep_details(clicked_id,0);

      }
		
   // ************************************  Search details   ************************************
		function allsearch()
		{
           // $('#emp_search').each(function() {
		   // var elem = $(this);
// 
		   // // Save current value of element
		   // elem.data('oldVal', elem.val());
// 		
		   // // Look for changes in the value
		   // elem.bind("propertychange keyup input paste", function(event){
		      // // If value has changed...
		      // if (elem.data('oldVal') != elem.val()) {
		       // // Updated stored value
		       // elem.data('oldVal', elem.val());
// 		
		       // // Do action
		       // // show_name_list(arr_name,id1);
		       // // result = $.grep(arr_name, function(s) { return s.match("sony") })
		       // var arr = [elem.val().toLowerCase()];
// 
				// var matcher = new RegExp(arr.join('|'));
				// var newarr = [];
				// var newarr_id = [];
								// // alert(""+arr_name);
				// $.each(arr_name, function(index, elem1) {
				   // if (elem1.toLowerCase().match(matcher)) {
				      // newarr.push(elem1);
				      // newarr_id.push(id1[index]);
				   // }
				// });
		       // // alert(elem.val().length);
		       // var div = document.getElementById('emp_list1');
							// while(div.firstChild){
	    					// div.removeChild(div.firstChild);
							// }
				// if((elem.val().length)!=0)	
				// {
		      		// show_name_list(newarr,newarr_id);
		      		// $('#emp_list1').show();
		      		// $('#emp_list').hide();
		      		// $('#emp_list2').hide();
				// }
				// else
				// {
					// // create_new_List();
					// $('#emp_list').show();
					// $('#emp_list1').hide();
					// $('#emp_list2').hide();
// 
				// }
// 		       
		     // }
		   // });
		 // });
		}
		



	// function show_bottom_div()
	// {
		 // $('#tm9_00').show();
      // document.getElementById("9_00").className ='classname2';
// 
      // $('.bottom_div ul li').click(function(){
//       	
      // // PLANNED CHECK FUNCTION 
      	// if (!$('#planned_checked').is(':checked')) {
          // $('#timeline li img').hide();
          // $('.classname2').removeClass('classname2');
          // var id2 = $(this).attr('id');
          // document.getElementById(id2).className ='classname2';
          // // alert(id2);
          // $('#tm'+id2).show();
//           
          // // // Clear pin 
          // if (hour_marker !=null)
				// {
					// hour_marker.setMap(null);   
				// }
			// var n = 0;	
		  // clearOverlays();
// 
// 	
          // for (var i in hour_click_hour)
          // {
// 
          	// var id2__ = id2.replace("_",":");
          	          // // alert(id2__+"    "+hour_click_hour[i]);
			// var id2_min = id2.split("_");
			// // alert(parseInt(id2_min[1])+30);
// 
			// var id2_min_con = id2_min[0]+":"+(parseInt(id2_min[1])+29);
          	// if (hour_click_hour[i] == id2__ ||(hour_click_hour[i] >= id2__ && hour_click_hour[i] <= id2_min_con) )
          	// {
//           		
// 
          		// show_address_id[n] = i;
          		// hour_marker_arr[n] = new google.maps.Marker({
			    // position: hour_click_lat_lng[i],
			    // title: ""+hour_click_lat_lng[i],
			    // draggable:false,
			    // animation: google.maps.Animation.DROP
// 			    
				// });
				// n++;
// 				
          	// }
          	// else
          	// {
          		// // if (hour_marker !=null)
				// // {
					// // hour_marker.setMap(null);   
				// // }
          	// }
          // }
//           
// 
          // for (var i in hour_marker_arr)
          // {
          	    // hour_marker_arr[i].setMap(map);
          	    // show_address(hour_marker_arr[i],show_address_id[i]);
          	  // // show_map_infowindow(hour_marker_arr[i],show_address_id[i]);
          // }		
          // }
//           
//           
//           
   		// });
// 
	// }