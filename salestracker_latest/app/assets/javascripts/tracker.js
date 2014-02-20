// var map;
// var actual_path_date;
// var hour_click_lat_lng = [],hour_click_hour = [],hour_marker_arr = [];
// var hour_marker;
// var arr_name = [];
// var id1 = [];
// 
   // // ************************************  DEVICE DEADY   ************************************
// $(document).ready(function(){
// 	
	// allsearch();
        // $('#date').datepicker({ dateFormat: 'dd M, yy' ,
        // onSelect: function(dateText) {
    				// // alert(dateText);
    		// get_all_sales_rep();
//     		
// 
  				// }});
        // var prettyDate = $.datepicker.formatDate('dd M, yy', new Date());
		// document.getElementById('date').value = prettyDate;
// 		
// 		
          // get_all_sales_rep();
//           
           // $('#date').click(function(){
           		 // $('#date').blur();
           // });
// 
      // // Calendar.setup({
      // //     dateField      : 'date',
      // //     triggerElement : 'calendar-icon'
      // //   })
     // $(window).resize(function(){
        // // $("#map_canvas").height($(document).height());
            // resizeContainers();
// 
    // });
//     
    // // show_map();
    // resizeContainers();
//     
      // $('#tm9').show();
      // document.getElementById("9").className ='classname2';
// 
      // $('.bottom_div ul li').click(function(){
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
          // for (var i in hour_click_hour)
          // {
          	// if (hour_click_hour[i] == id2)
          	// {
          		// // alert(hour_click_hour[i]);
          		// hour_marker_arr[n] = new google.maps.Marker({
			    // position: hour_click_lat_lng[i],
			    // title: ""+hour_click_lat_lng[i],
			    // draggable:false,
			    // animation: google.maps.Animation.DROP
// 			    
				// });
				// n++;
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
// 
          // }		
//          
// 
          // // show_pin(hour_marker_arr);
// 
          // // hour_click_lat_lng
			// // hour_click_hour 
//           
         // });
//           
//         
// }); 
// 
// 
	// function clearOverlays() {
	  // for (var i = 0; i < hour_marker_arr.length; i++ ) {
	    // hour_marker_arr[i].setMap(null);
	  // }
	  // hour_marker_arr = [];
// 	 
	// }
// 	
// 	
   // // ************************************  SHOW LIST OF SALES REP   ************************************
   // function createList(msg)
   // {
	        // // var arr = ['list','jbjcfd','yufftyysfyf'];
	        // // var id1 = ['1','2','3'];
// 		
// 
	   	// for (var j in msg)
	   	// {
	   		// var employee_code = msg[j]['employee_code'];
	   		// var name1 = msg[j]['name'];
	   		// if (j==0)
	   		// {
	   			// get_sales_rep_details(employee_code);
	   		// }
// 
// 	   		
	   		// arr_name[j] = name1;
	   		// id1[j] = employee_code;
	   	// }
// // 	        
			// init_map();
			// show_name_list(arr_name,id1);
// 
// 
// 			
// 		
// 		
    // }
//     
       // // ************************************  SHOW LIST OF SALES REP   ************************************
    // function show_name_list(arr,id12)
    // {
    	// alert("hai");
    	// $(".emp_list").append("<ul></ul>");
			// for(var i in arr) {
			  // if (i==0) {
			  	// // alert("dd");
			        // var li = "<li id="+id12[i]+" onclick=show("+id12[i]+") class=classname><img src=assets/name_marker.png class=name_marker>";
// 
			  // }
			  // else
			  // {
			  	// // alert("dd1");
// 
			    // var li = "<li id="+id12[i]+" onclick=show("+id12[i]+")><img src=assets/name_marker.png class=name_marker>";
			  // }
			      // $(".emp_list ul").append(li.concat(arr[i]))
			     	// $('#'+id12[0]+' img').show();
// 
			// }
    // }
//     
//       
   // // ************************************  PARTICULAR SALES REP CLICK DETAILS   ************************************
	// function show(clicked_id)
	 // {
 			 // $('.name_marker').hide();
          // $('.classname').removeClass('classname');
          // // var id1 = $(this).attr('id');
          // // alert(clicked_id);
          // document.getElementById(clicked_id).className ='classname';
          // $('#'+clicked_id+' img').show();	   
          // get_sales_rep_details(clicked_id);
// 
//           
      // }
//            
    // function init_map()
    // {
    	 // var myOptions = {
	          		// center : new google.maps.LatLng(20.397, 78.644),
	          		// zoom : 3,
	                // mapTypeControl: true,
	                // mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
	                // navigationControl: true
	                // // mapTypeId: google.maps.MapTypeId.HYBRID
	       // }     
	       // map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
// 	    
// 	   	
    // }       
//            
   // // ************************************  SHOW MA   ************************************
	// function show_map(planned_path,actual_path){
	   	// var count_planned = planned_path.length;
	   	// var count_actual = actual_path.length;
	   	// var latlong =[];
	   	// var latlong1 =[];
	   	// var polyline,polyline1;
	   	// var bounds = new google.maps.LatLngBounds();
// 
	   	// init_map();
	   	// for (var i=0;i<count_actual;i++)
	   	// {
	   		// var lat1 = actual_path[i]['lat'];
	   		// var lng1 = actual_path[i]['lng'];
	   		// latlong1[i] = new google.maps.LatLng(lat1,lng1);
	   		// bounds.extend(latlong1[i]);
// 
	   		// // alert(planned_path[i]['lat']);
	   		// // alert(planned_path[i]['lng']);
	   	// }
// 	   	
	   	// for (var j=0;j<count_planned;j++)
	   	// {
	   		// var lat = planned_path[j]['lat'];
	   		// var lng = planned_path[j]['lng'];
	   		// latlong[j] = new google.maps.LatLng(lat,lng);
	   		// bounds.extend(latlong[j]);
// 
	   		// // alert(planned_path[i]['lat']);
	   		// // alert(planned_path[i]['lng']);
	   	// }
// 	   	
// 	      
		// try{    
			// polyline = show_polyline(latlong,'#e23030');
			// polyline1 = show_polyline(latlong1,'#2ecc71')
			// show_marker(latlong1);
			// show_marker(latlong);
			// // show_pin(latlong1[1])
// 			
				  // polyline.setMap(map);   
			      // polyline1.setMap(map);
			       // map.fitBounds(bounds);
    				// map.panToBounds(bounds);     
// 			     
		// }
		// catch(e){
			  // polyline.setMap(null);   
		       // polyline1.setMap(null);   
		// }
	      // // marker.setMap(map);   
// 	      
//     
	// }
// 	
   // // ************************************  MAP EMPTY   ************************************
	// function null_polyline()
	// {
		 // var polyline = new google.maps.Polyline();
	// return polyline;
	// }	
// 	
   // // ************************************  DRAW ROUTES   ************************************
	// function show_polyline(latlong,color)
	// {
		// var polyline ;
		// try{
		  // polyline = new google.maps.Polyline({
	          // path: latlong,
	          // strokeColor: color,
	          // strokeOpacity: 1.0,
	          // strokeWeight: 5
	      // });
	     // }
	     // catch(e){}
	// return polyline;
	// }	
// 	
   // // ************************************  SHOW MARKER   ************************************
	// function show_marker(latlong1)
	// {
		// try{
		// for (var j=0;j<latlong1.length;j++)
		   	// {
		   	// var marker = new google.maps.Marker({
	    		// position: latlong1[j],
	    		// draggable:false,
			    // icon: {
			    // path: google.maps.SymbolPath.CIRCLE,
			    // scale: 4,
				// },
			    // animation: google.maps.Animation.DROP,
			    // map : map
				// });
			// }
			// }
		     // catch(e){}
// 	  
	// }
// 	
	// // ************************************  SHOW MARKER   ************************************
	// function show_pin(latlong1)
	// {
		// try{
				// // if (hour_marker !=null)
				// // {
					// // hour_marker.setMap(null);   
				// // }
// 
			   // hour_marker = new google.maps.Marker({
			    // position: latlong1,
			    // title:"Hello World!",
			    // draggable:true,
			    // animation: google.maps.Animation.DROP
// 			    
				// });
// 				
				// hour_marker.setMap(map);
// 				
			// }
		     // catch(e){}
// 	  
	// }
// 	
// 	
// 
   // // ************************************   HOURS PIN DISPLAY   ************************************
	// function hour_pin_display(data)
	// {
		// var actual_path1 = data['message']['actual_path'];
	   	// var count_actual1 = actual_path1.length;
	   	// var latlong11 =[];
	   	// var polyline,polyline1;
// 	   	
	   	// for (var i=0;i<count_actual1;i++)
	   	// {
	   		// var lat1 = actual_path1[i]['lat'];
	   		// var lng1 = actual_path1[i]['lng'];
	   		// var date = actual_path1[i]['date'];
			// var myDate = new Date(date);
			// // alert(myDate.getHours());	   		
			// hour_click_lat_lng[i] = new google.maps.LatLng(lat1,lng1);
			// hour_click_hour[i] = myDate.getHours();
	   		// // alert(planned_path[i]['lat']);
	   		// // alert(planned_path[i]['lng']);
	   	// }
// 	   	
// 	   
	// }
// 
// 
   // // ************************************  SCREEN SIZE   ************************************
	// function resizeContainers() {
			// var $window = $(window);
// 	
			// var wWidth  = $window.width();
			// var wHeight = $window.height();
	    // $(".left_div").css("width", (wWidth*80/100) + "px");
	    // $(".left_div").css("height", (wHeight*100/100) + "px");
	    // $("#map_canvas").css("width", (wWidth*80/100) + "px");
	    // $(".user_area").css("width", (wWidth*20/100) + "px");
	    // $("#map_canvas").css("height", (wHeight*95/100) + "px");
	    // $(".user_area").css("height", (wHeight*25/100) + "px");
	    // $(".employee_list").css("width", (wWidth*20/100) + "px");
	    // $(".employee_list").css("height", (wHeight*70/100) + "px");
	    // $(".right_div").css("height", (wHeight*100/100) + "px");
	    // $(".right_div").css("width", (wWidth*20/100) + "px");
	    // $(".bottom_div").css("height", (wHeight*5/100) + "px");
	    // $(".bottom_div").css("width", (wWidth*80/100) + "px");
	    // $(".emp_search").css("height", (wHeight*5/100) + "px");
	    // $(".emp_search").css("width", (wWidth*17.65/100) + "px");
	// }
// 
   // // ************************************  ALL SALES MAN AJAX REQUEST   ************************************
	// function get_all_sales_rep()
		// {
			// var role = 5;
    		// var date1 = $("#date").val();
    		// var date = $.datepicker.formatDate('yy-mm-dd', new Date(date1));
			// // alert(date);
    		// // var date = '2013-07-05';
    		// var params ={'role': role, 'date' : date };
			// $.ajax({
					// url : "/employees/get_all_sales_rep",
					// data : params,
					// type : "POST",
					// error : function(error) {
						// // hideLoader('fail', 'Sorry Server down,\n Please try again later', '');
// 						
					// },
					// success : function(data) {
						// var success = data['success'];
// 						
						// if(success == "1")
						// {
							// // $('.emp_list').empty();
							 // arr_name = [];
							 // id1 = [];
							// var div1 = document.getElementById('emp_list');
							// while(div1.firstChild){
	    					// div1.removeChild(div1.firstChild);
							// }
							// var msg = data['message'];
							// alert(JSON.stringify(data['message']));
// 
							// createList(msg);
// 
						// }
						// else
						// {
							// alert(JSON.stringify(data['message']));
						// }
					// }
				// });
		// }
// 	
   // // ************************************  PARTICULAR SALES REP DETAILS   ************************************
	// function get_sales_rep_details(employee_code)
		// {
    		// var params ={'id': employee_code };
			// $.ajax({
					// url : "/employees/get_sales_rep_details",
					// data : params,
					// type : "POST",
					// error : function(error) {
						// // hideLoader('fail', 'Sorry Server down,\n Please try again later', '');
// 						
					// },
					// success : function(data) {
						// var success = data['success'];
// 						
						// if(success == "1")
						// {
							 // hour_click_lat_lng = [];
	  						// hour_click_hour = [];
							// var msg = data['message'];
							// var planned_path = data['message']['planned_path'];
							// var actual_path = data['message']['actual_path'];
							// // alert(JSON.stringify(actual_path));
							// actual_path_date = msg;
							// show_map(planned_path,actual_path);
							// hour_pin_display(data);
// 
						// }
						// else
						// {
							// alert(JSON.stringify(data['message']));
						// }
					// }
				// });
		// }
// 		
   // // ************************************  Search details   ************************************
		// function allsearch()
		// {
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
// 			
				// var newarr = [];
				// var newarr_id = [];
				// $.each(arr_name, function(index, elem1) {
				   // if (elem1.toLowerCase().match(matcher)) {
				      // newarr.push(elem1);
				      // newarr_id.push(id1[index]);
// 
				     // // alert(index);
// 
				   // }
				// });
		       // // alert(newarr.length);
		       // var div = document.getElementById('emp_list');
							// while(div.firstChild){
	    					// div.removeChild(div.firstChild);
							// }
		      // show_name_list(newarr,newarr_id);
// 
// 		       
		     // }
		   // });
		 // });
		// }
// 		
   // // ************************************  COORDINATES   ************************************
// 		
		  // // var polylineCoordinates = [
	            // // new google.maps.LatLng(10.013566,76.331549),
	            // // new google.maps.LatLng(10.013566,76.331463),
	            // // new google.maps.LatLng(10.013503,76.331313),
	            // // new google.maps.LatLng(10.013482,76.331205),
	            // // new google.maps.LatLng(10.013419,76.330926),
				// // new google.maps.LatLng(10.013334,76.330712),
				// // new google.maps.LatLng(10.013313,76.330411),
				// // new google.maps.LatLng(10.013292,76.330175),
				// // new google.maps.LatLng(10.013228,76.329854),
				// // new google.maps.LatLng(10.013144,76.329553),
				// // new google.maps.LatLng(10.013059,76.329296),
				// // new google.maps.LatLng(10.012996,76.329017),
				// // new google.maps.LatLng(10.012869,76.328802),
				// // new google.maps.LatLng(10.012785,76.328545),
				// // new google.maps.LatLng(10.012700,76.328223),
				// // new google.maps.LatLng(10.012679,76.328030),
				// // new google.maps.LatLng(10.012658,76.327837),
				// // new google.maps.LatLng(10.012637,76.327600),
				// // new google.maps.LatLng(10.012573,76.327322),
				// // new google.maps.LatLng(10.012552,76.327043),
				// // new google.maps.LatLng(10.012552,76.326807),
				// // new google.maps.LatLng(10.012510,76.326613),
				// // new google.maps.LatLng(10.012447,76.326399),
				// // new google.maps.LatLng(10.012404,76.326227),
	      // // ];
	      // // var polyline = new google.maps.Polyline({
	          // // path: latlong,
	          // // strokeColor: '#e23030',
	          // // strokeOpacity: 1.0,
	          // // strokeWeight: 5
	      // // });
// // 	
	 // // var polyline1 = new google.maps.Polyline({
	          // // path: latlong1,
	          // // strokeColor: '#2ecc71',
	          // // strokeOpacity: 1.0,
	          // // strokeWeight: 5
	      // // });
// 	
	// // for (var j=0;j<latlong.length;j++)
	   	// // {
	   	// // var marker = new google.maps.Marker({
    		// // position: latlong[j],
    		// // draggable:true,
		    // // icon: {
		    // // path: google.maps.SymbolPath.CIRCLE,
		    // // scale: 4,
			// // },
		    // // animation: google.maps.Animation.DROP,
		    // // map : map
			// // });
		// // }
