 var planned_customer_name = [],planned_customer_phone_number = [],lat_lng_address_actual=[];
 var infoWindowList_planned = [],infoWindowList_actual = [];
  // ************************************  Initialized MAP  ************************************
    function init_map()
    {
    	var lat = 7.752370, lng = 5.996330;
        // navigator.geolocation.getCurrentPosition(GetLocation);
 		// function GetLocation(location) {
 			// lat = location.coords.latitude;
 			// lng = location.coords.longitude;
 			// var myOptions = {
	          		// center : new google.maps.LatLng(lat, lng),
	          		// zoom : 8,
	                // mapTypeControl: true,
	                // mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
	                // navigationControl: true
	                // // mapTypeId: google.maps.MapTypeId.HYBRID
	       // }     
	       // map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);
// 		 
		// }
		  
    	 var myOptions = {
	          		center : new google.maps.LatLng(lat, lng),
	          		zoom : 4,
	                mapTypeControl: true,
	                mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
	                navigationControl: true
	                // mapTypeId: google.maps.MapTypeId.HYBRID
	       }     
	       map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

	   	
    }
   //
    function show_map_all_data(sale_data)
    {
 init_map();

//console.log(locations);

   var infowindow = new google.maps.InfoWindow();

    var marker, i;
try
{
    for (i = 0; i < sale_data.length; i++) {
      marker = new google.maps.Marker({
        position: new google.maps.LatLng(sale_data[i].GPS_latitude, sale_data[i].GPS_longitude),
		  icon: {
          path: google.maps.SymbolPath.CIRCLE,
			    strokeColor: '#8e2014',
			    scale: 4,
				strokeOpacity: 1.0,
	          strokeWeight: 10,
			  fillColor: '#8e2014',
			  animation: google.maps.Animation.DROP,
    },
        map: map
      });

      google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(sale_data[i].GPS_latitude + "," + sale_data[i].GPS_longitude);
          infowindow.open(map, marker);
        }
      })(marker, i));

    }
}
catch (e)
{

}
    }



    function show_cluster(sale_data)
    {

 init_map();
var mcOptions = {styles: [{
height: 53,
url: "images/m1.png",
width: 53
},
{
height: 56,
url: "images/m2.png",
width: 56
},
{
height: 66,
url: "images/m3.png",
width: 66
},
{
height: 78,
url: "images/m4.png",
width: 78
},
{
height: 90,
url: "images/m5.png",
width: 90
}],maxZoom: 18};

 var infowindow = new google.maps.InfoWindow();
var gmarkers = [];
for (var i = 0; i < sale_data.length; i++) {
        var lat = sale_data[i].GPS_latitude;
        var lng = sale_data[i].GPS_longitude;
        var latLng = new google.maps.LatLng(lat, lng);
        var marker = new google.maps.Marker({map: map, position: latLng,icon: {
          path: google.maps.SymbolPath.CIRCLE,
			    strokeColor: '#8e2014',
			    scale: 4,
				strokeOpacity: 1.0,
	          strokeWeight: 10,
			  fillColor: '#8e2014'
    }});
	 google.maps.event.addListener(marker, 'click', (function(marker, i) {
        return function() {
          infowindow.setContent(sale_data[i].GPS_latitude + "," + sale_data[i].GPS_longitude);
          infowindow.open(map, marker);
        }
      })(marker, i));
        gmarkers.push(marker);
}

var markerCluster = new MarkerClusterer(map, gmarkers,mcOptions);
 
    }
		 
   // ************************************  SHOW MAP  ************************************
	function show_map(planned_path,actual_path){
	   	var count_planned = planned_path.length;
	   	var count_actual = actual_path.length;
	   
	   	var bounds = new google.maps.LatLngBounds();
		var inter = "";
		
		
	   	init_map();

	   	for (var i=0;i<count_actual;i++)
	   	{
	   		var lat1 = actual_path[i]['lat'];
	   		var lng1 = actual_path[i]['lng'];
	   		actual_latlong[i] = new google.maps.LatLng(lat1,lng1);
	   		bounds.extend(actual_latlong[i]);
	   							
	   	}
	   	
	   	
	   	for (var j=0;j<count_planned;j++)
	   	{
	   		var lat = planned_path[j]['customer']['lat'];
	   		var lng = planned_path[j]['customer']['lng'];
	   		planned_latlong[j] = new google.maps.LatLng(lat,lng);
	   		bounds.extend(planned_latlong[j]);
	   		lat_lng_address[j] = planned_path[j]['customer']['address'];
	   		planned_customer_name[j] =  planned_path[j]['customer']['name'];
	   		planned_customer_phone_number[j] =  planned_path[j]['customer']['phone_number'];
	   		// get_address(lat,lng,j);

	   	}
	   	
	   	map.fitBounds(bounds);
		map.panToBounds(bounds);  
	    
	    actual_planned_path();

    
	}
	
	
	
	function actual_planned_path()
	{
		try{    

			planned_polyline = show_polyline(planned_latlong,'#e23030');
			actual_polyline = show_polyline1(actual_latlong,'#2ecc71')
			// show_pin(latlong1[1])
		    		
		    		 clearInterval(intervel);


					var red_color =true;
		    		 intervel=self.setInterval(function(){
		    		 				if(red_color)
		    		 				{
		    		 					red_color =false;
		    		 					show_marker(planned_latlong);
		    		 					 planned_polyline.setMap(map);  
		    		 				}
		    		 				else
		    		 				{
						    				 show_actual_path_marker();
		    		 						actual_polyline.setMap(map);
		    		 						show_final_parker();

		    		 						clearInterval(intervel);
		    		 				}

							},1000);

			      
// 		Planned check box 
    	$("#planned_checked").click(function(){
			
			if ($('#planned_checked').is(':checked')) {
		    		clearOverlays();
  					actual_polyline.setMap(null);
					clear_pin();

			} else {
			           	// $('#tm9_00').show();
						$('#tm9_00').trigger('click');

						//actual_polyline.setMap(map);
						//show_actual_path_marker();
						//show_final_parker();
						
			} 
		});
// 		
			     
		}
		catch(e){
			  polyline.setMap(null);   
		      polyline1.setMap(null);   
		}
	      // marker.setMap(map);   
	}
	
	
	
   // ************************************   HOURS PIN DISPLAY   ************************************
	function hour_pin_display(data)
	{
		var actual_path1 = data['message']['actual_path'];
	   	var count_actual1 = actual_path1.length;
	   	var latlong11 =[];
	   	var polyline,polyline1;
	   	
	   	for (var i=0;i<count_actual1;i++)
	   	{
	   		var lat1 = actual_path1[i]['lat'];
	   		var lng1 = actual_path1[i]['lng'];
	   		var date = actual_path1[i]['date'];
	   		var time = actual_path1[i]['time'];
	   		var dateTime = date+" "+time;
			var myDate = new Date(dateTime);
			// alert(myDate.getHours());	   		
			hour_click_lat_lng[i] = new google.maps.LatLng(lat1,lng1);
			// hour_click_hour[i] = myDate.getHours();
			
			var min = ""+myDate.getMinutes();
			if (min.length == 1)
			{
				min = min+"0";
			}
			
			// alert(myDate.getHours()+":"+min);
			// hour_click_hour[i] = myDate.getHours();
			hour_click_hour[i] = myDate.getHours()+":"+min;
			// alert(myDate.getHours()+":"+min);
	   		// alert(planned_path[i]['lat']);
	   		// alert(planned_path[i]['lng']);
	   	}
	}
	
	function show_final_parker()
	{
		  for (var i in actual_path_marker)
          {
          	   actual_path_marker[i].setMap(map);

          }		
	}
	
		 // ************************************  SHOW MARKER   ************************************
	function show_actual_path_marker()
	{
		try{
					clear_pin();

		for (var j=0;j<actual_latlong.length;j++)
		   	{
		   		var j_ = 4;
		   		if (j == 0)
		   		{
		   			j_ = 6
		   		}
		   		else
		   		{
		   			j_ = 4
		   		}
		   		
		   		actual_path_marker[j] = new google.maps.Marker({
		    		position: actual_latlong[j],
		    		title: ""+actual_latlong[j],
		    		draggable:false,
				    // icon:"images/timeline_marker.png" ,
				    animation: google.maps.Animation.DROP
				   
					});
		   					
				if ((actual_latlong.length-1) == j && Sales_rep_last_date == 1)
				{
					actual_path_marker[j].setIcon("images/timeline_marker.png");
				}
				else
				{
					actual_path_marker[j].setIcon({ path: google.maps.SymbolPath.CIRCLE,strokeColor: 'green', scale:j_	});
				}
				 
				 show_address(actual_path_marker[j],j,hour_click_hour[j]);

			}
			}
		     catch(e){}
	  
	}
	
	// ************************************  MAP EMPTY   ************************************
	function null_polyline()
	{
		  planned_polyline = new google.maps.Polyline();
		  actual_polyline = new google.maps.Polyline();

	}	
	
   // ************************************  DRAW ROUTES   ************************************
	function show_polyline(latlong,color)
	{
		var polyline ;
		try{
		  polyline = new google.maps.Polyline({
	          path: latlong,
	          strokeColor: color,
	          strokeOpacity: 1.0,
	          strokeWeight: 2
	      });
	     }
	     catch(e){}
	return polyline;
	}	
	

	  // ************************************  DRAW ROUTES   ************************************
	function show_polyline1(latlong,color)
	{
		var polyline ;
		try{
		  polyline = new google.maps.Polyline({
	          path: latlong,
	          strokeColor: color,
	          strokeOpacity: 1.0,
	          strokeWeight: 5
	      });
	     }
	     catch(e){}
	return polyline;
	}	
	

	
   // ************************************  SHOW MARKER   ************************************
	function show_marker(latlong1)
	{
		try{
			infoWindowList_planned = [];
		for (var j=0;j<latlong1.length;j++)
		   	{
		   		var j_ = 4;
		   		if (j == 0)
		   		{
		   			j_ = 6
		   		}
		   		else
		   		{
		   			j_ = 4
		   		}
		   	var marker = new google.maps.Marker({
	    		position: latlong1[j],
	    		title: ""+latlong1[j],
	    		draggable:false,
			    icon: {
			    path: google.maps.SymbolPath.CIRCLE,
			    strokeColor: '#8e2014',
			    scale: j_,
				},
			    animation: google.maps.Animation.DROP,
			    map : map
				});
				
				show_map_infowindow(marker,j);

			}
			}
		     catch(e){}
	  
	}
	
	
	
	// ************************************  SHOW MARKER   ************************************
	function show_pin(latlong1)
	{
		try{
				// if (hour_marker !=null)
				// {
					// hour_marker.setMap(null);   
				// }

			   hour_marker = new google.maps.Marker({
			    position: latlong1,
			    // title:"Hello World!",
			    draggable:true,
			    animation: google.maps.Animation.DROP
			    
				});
				
				hour_marker.setMap(map);
				
			}
		     catch(e){}
	  
	}
	
	// ************************************  Clear Markers actual plan  ************************************
	function clear_pin() {
		
		for (var j=0;j<actual_path_marker.length;j++)
		   	{
		    	actual_path_marker[j].setMap(null);
	  		}
	 		actual_path_marker = [];
	}
	
	
	
	
	// ************************************  Clear Markers   ************************************
	function clearOverlays() {
	  for (var i = 0; i < hour_marker_arr.length; i++ ) {
	    hour_marker_arr[i].setMap(null);
	  }
	  hour_marker_arr = [];
	 
	}
	
		// ************************************   SHOW INFO WINDOW PLANNED MARKER   ************************************
	function show_map_infowindow(hour_marker_arr_val,i)
	{
		 var infowindow = new google.maps.InfoWindow();
		 infoWindowList_planned[i] = infowindow;
		
		  google.maps.event.addListener(hour_marker_arr_val, 'click', function(event) {
		 		var on_click_lat_long = this;
		 		closeAllInfoWindow();
				   infowindow.setContent('<div class=show_message_gmap>Name   :   '+planned_customer_name[i]+'</br>Phone Number   :   '+planned_customer_phone_number[i]+'</br>Address	:   '+lat_lng_address[i]+'</div>');

		 		// infowindow = new google.maps.InfoWindow({
    						// content: '<div class=show_message_gmap>Name   :   '+planned_customer_name[i]+'</br>Phone Number   :   '+planned_customer_phone_number[i]+'</br>Address	:   '+lat_lng_address[i]+'</div>'
				// });

    					infowindow.open(map,on_click_lat_long);		
  			});


	}


	 function closeAllInfoWindow(){
           for(var i=0; i<infoWindowList_planned.length; i++){
                infoWindowList_planned[i].close();
           }
           for(var i=0; i<infoWindowList_actual.length; i++){
                infoWindowList_actual[i].close();
           }
           
           
     }        
	
// ************************************  show address details planned path ************************************
	function get_address_details(actual_path){
	   	var count_planned = actual_path.length;
		var inter = "";
		
 		inter=self.setInterval(function(){
 		for (var j=0;j<count_planned;j++)
	   	{
	   		var lat = actual_path[j]['lat'];
	   		var lng = actual_path[j]['lng'];
	   		
	   		get_address(lat,lng,j);
	   		clearInterval(inter);


	   	}
	 },200);
	 
	 

	}
	
	
// ************************************  show address details using latitude & longitude ************************************
	function get_address(lat,lng,i)
	{
		 var geocoder = new google.maps.Geocoder();
		 
  							
						// "lat  : "+lat_long_gmap.lat()+"</br>  lng : "+lat_long_gmap.lng()
				
		  var latlng = new google.maps.LatLng(parseFloat(lat), parseFloat(lng));
		  // var latlng = new google.maps.LatLng("", "");
			try{
			geocoder.geocode({'latLng': latlng}, function(results, status) {
				
				if (status == google.maps.GeocoderStatus.OK) {
				    	
				      if (results[1]) {
				        // alert(results[1].formatted_address);
						lat_lng_address_actual[i] = results[1].formatted_address;
				      // return results[1].formatted_address;
				      } else {
				        // alert(status);

						lat_lng_address_actual[i] = "lat : "+lat+"     lng : "+lng;
				      }
				    } else {
				        // alert(status);

						lat_lng_address_actual[i] = "lat : "+lat+"     lng : "+lng;
				    }
			});
				  
				   
			}
			catch(e)
			{
				alert(e);
			}
			
					
		
			
	}

