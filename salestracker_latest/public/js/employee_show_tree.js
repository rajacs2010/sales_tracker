   // ************************************  SHOW LIST OF SALES REP   ************************************
    function show_name_list(arr,id12)
    {
    	$(".emp_list1").append("<ul></ul>");
			for(var i in arr) {
			  if (i==0) {
			  	// alert("dd");
			        var li = "<li id="+id12[i]+" onClick=show("+id12[i]+") class=classname><img onClick=show_list()  src=/images/name_marker.png class=name_marker style='height:20px'>";

			  }
			  else
			  {
			  	// alert("dd1");

			    var li = "<li id="+id12[i]+" onclick=show("+id12[i]+")><img onClick=show_list()  src=/images/name_marker.png class=name_marker style='height:20px'>";
			  }
			      $(".emp_list1 ul").append(li.concat(arr[i]))
			     	$('#'+id12[0]+' img').show();

			}
			
			
    }
    
    
    
    	
   // ************************************  SHOW LIST OF SALES REP   ************************************
   function create_new_List()
   {
	   		
	   			var div = document.getElementById('emp_list');
							while(div.firstChild){
	    					div.removeChild(div.firstChild);
							}

    			$(".emp_list").append("<ul></ul>");
    		if (Show_all_emp_details.length != 1)
    		{
	   		for (var j=0;j<Show_all_emp_details[1].length;j++)
	   		{
	   			  // if (j==0) {
			  	// alert("dd");
			        var li = "<li id=1_"+Show_all_emp_details[1][j]['employee_code']+"  ><span onclick=show_new_list('1_"+Show_all_emp_details[1][j]['employee_code']+"')>"+Show_all_emp_details[1][j]['employee_name']+"</span></li>";
// 
				  // }
				  // else
				  // {
				  	// // alert("dd1");
// 	
				    // var li = "<li id="+Show_all_emp_details[1][j]['employee_code']+" onclick=show("+Show_all_emp_details[1][j]['employee_code']+")>";
				  // }
	   			
	   			$(".emp_list ul").append(li);

	   		}
	   		}
	   		arr_name = [];
	   		id12 =[];
	   		var array_length = (Show_all_emp_details.length)-1;
	   		
	   		for (var k=0;k< Show_all_emp_details[array_length].length;k++)
	   		{
	   			arr_name[k] = Show_all_emp_details[array_length][k]['employee_name'];
	   			id1[k] = Show_all_emp_details[array_length][k]['employee_code'];
	   		}
 	        
 	        
	   		// alert(id1);
			// init_map();
			// show_name_list(arr_name,id1);
			
    }
    
//     Show manager dropdown
    function show_list_(emp_code)
    {
    	var n=emp_code.split("_");
    	var page_no = parseInt(n[0])+1;
    	var employee_code = n[1];
    	var child = $("#"+emp_code).children().length;	
    	    	
								// alert(check_Sales_rep(employee_code,page_no));
	
// 		Check Sales rep or not		
		if (Show_all_emp_details.length == page_no || check_Sales_rep(employee_code,page_no))
	   		{
	   			$('.classname').removeClass('classname');
	   			$('.name_marker').remove();
	   			
	   			$("#"+emp_code+" span").addClass('classname');
	   			
	   			var img_hover ="<img onClick=show_list()  src=/images/name_marker.png class=name_marker  >";
			      $("#"+emp_code).append(img_hover);
						$('.name_marker').show();	  
						get_sales_rep_details(employee_code,0);
	   			          

	   		}
	   		else
	   		{	
	   			//   MANAGERS below create child
	   			if (child == 1)
	   			{	   			
						$("#"+emp_code).append("<ul></ul>");
		    		for (var j=0;j<Show_all_emp_details[page_no].length;j++)
			   		{
			   			if (employee_code == Show_all_emp_details[page_no][j]['manager_code'])
			   			{		
			   				var li = "<li id="+page_no+"_"+Show_all_emp_details[page_no][j]['employee_code']+"  ><span style='font-size:"+(17-parseInt(page_no))+"px' onclick=show_new_list('"+page_no+"_"+Show_all_emp_details[page_no][j]['employee_code']+"') id='ab"+page_no+"_"+Show_all_emp_details[page_no][j]['employee_code']+"'>"+Show_all_emp_details[page_no][j]['employee_name']+"</span></li>";
				   			$("#"+emp_code+" ul").append(li);
			   			}
			   			
			   		}
		   		}
		   		else
		   		{
		   			//   MANAGERS SHOW HIDE
		   			if ($("#"+emp_code+" ul").is(":visible"))
		   			{
		   				$("#"+emp_code+" ul").hide();
		   			}
		   			else
		   			{
		   				$("#"+emp_code+" ul").show();
		   			}
		   			
		   			
		   		}
	   		}		
    			   		
    }
    
//    IF Check sales rep child yse or not
   	function check_Sales_rep(employee_code,page_no)
   	{
   		var is_not_empty = true;
   		var page_no1 =parseInt(page_no);
   		
   		
   		try{
	   		for (var j=0;j<Show_all_emp_details[page_no1].length;j++)
			{
				   			if (employee_code == Show_all_emp_details[page_no1][j]['manager_code'])
				   			{		
				   				is_not_empty = false;
				   			}
				   			
			}
		}catch(e){}		
				   				
		return is_not_empty;		   		
   	}
    
    
    //  Tree items on click event 
    function show_new_list(emp_code)
    {
    	show_list_(emp_code);
    	// $('').remove();
    	// if( $('#leftmenu').is(':empty') ) {
    		   		
    }
    
 
    