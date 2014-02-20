var show_details_sr_name = "",show_details_sr_phone = "";
function show_planned()
{
	 var div = document.getElementById('sales_rep_planned_details');
							while(div.firstChild){
	    					div.removeChild(div.firstChild);
							}
	
	$(".sales_rep_planned_details").append("<div><div id='sr_details'><img id=sr_photo_table src='../images/profile.jpeg'/>"
											+"<div id=sr_name_phone_table ><span id=sr_name_table>Name  :  "+show_details_sr_name+"</span><span id=sr_phone_table>Phone Number  :  "+show_details_sr_phone+"</span></div></div>"
											+"<h3><a href='#'><span id=actual_route_show_details class=route_show_details>Actual Route</span></a>"
											+"  |  <a href='#'><span id=planned_route_show_details >Planned Route</span></a></h2></div>"
											+"<table class=table__>"
											+"<th class=first_col>Seq No</th><th class=second_col>Time</th><th class=third_col>Address</th>"
											+"<table class=table1__>"
											+"<th class=first_col>Seq No</th><th class=second_col>Name</th><th class=third_col>Phone number</th><th class=forth_col>Address</th>");
	
	
	var li="",li1="";
			for(var i in hour_click_lat_lng) {
				// alert("working");
				if (seq[i] != null)
				{
				
			         // li += "<tr class=tr__><td>"+seq[i]+"</td><td>"+lat__[i]+"</td><td>"+lng__[i]+"</td></tr>";
			         li += "<tr class=tr__><td>"+seq[i]+"</td><td>"+hour_click_hour[i]+"</td><td>"
			         			+lat_lng_address_actual[i]+"</td></tr>";
			
			    }  

			}
			
			for(var i in lat_lng_address) {				
				
			         // li += "<tr class=tr__><td>"+seq[i]+"</td><td>"+lat__[i]+"</td><td>"+lng__[i]+"</td></tr>";
			         li1 += "<tr class=tr__><td>"+(parseInt(i)+1)+"</td><td>"+planned_customer_name[i]+"</td><td>"+planned_customer_phone_number[i]+"</td><td>"+lat_lng_address[i]+"</td></tr>";
			
			     

			}
			li += "</table>"
			li1 += "</table>"
			// alert(li);
			$(".table__").append(li);
			$(".table1__").append(li1);
			
			
			
			
			
			
			
			$('#actual_route_show_details').click(function(){
				
				$('#planned_route_show_details').removeClass('route_show_details');
				$('#actual_route_show_details').addClass('route_show_details');
				$(".table__").show();
				$(".table1__").hide();

			});

			$('#planned_route_show_details').click(function(){
				$('#actual_route_show_details').removeClass('route_show_details');
				$('#planned_route_show_details').addClass('route_show_details');
				$(".table__").hide();
				$(".table1__").show();
			});

}

