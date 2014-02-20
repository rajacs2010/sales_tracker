function user_authentication()
{
	
	admin_events();
	
}


function admin_events()
{
	$('.logout_admin').click(function(){
		
		$('#employee_name').val("");
		$('#employee_code').val("");
		$('#employee_password').val("");
		$('#employee_confirm_pwd').val("");
		$('.employee_role').val("");
		$('#desgination').val("");
		$('#logout').trigger("click");
		
		
	});
	
// 	Save new User
	$('.save_new_user').click(function(){
		
		var employee_name,employee_code,new_password,confirm_password,employee_role;
		employee_name = $('#employee_name').val();
		employee_code = $('#employee_code').val();
		new_password = $('#employee_password').val();
		confirm_password = $('#employee_confirm_pwd').val();
		employee_role = $('.employee_role').val();
		
		
		if (employee_name != "" && employee_code != "" && new_password != "" && confirm_password != "" && employee_role != "")
		{
			if( new_password == confirm_password)
			{
				admin_create_new_employee(employee_code,employee_name,new_password,employee_role,2);
			}
			else
			{
				alert("Please Enter currect password");
			}
		}
		else{
			alert("Please fill this form")
		}
		
	});
	
	
	$('#employee_code').focusout(function() {
		admin_create_new_employee($(this).val(),"","","",1);
	});
}



// EMPLOYEE CODE FOCUS OUT 
function employee_code_focus_out(name,role,desg)
{
		
		$('#employee_name').val(name);
		$('.employee_role').val(role);
		$('#desgination').val(desg);
		
		if (name != "" && desg != "")
		{
			$('#employee_name').prop("disabled", true);
			$('#desgination').prop("disabled", true);
		}
		else
		{
			$('#employee_name').prop("disabled", false);
			$('#desgination').prop("disabled", false);		
		}
		
		
		create_dropdown(role);
		
		
		
}


function create_dropdown(role)
{
		var selectHTML ="",brand_dropdown = [];
		
		if (role == "WWCVL" || role == "KD" )
		{
			$('.employee_role').prop("disabled", true);
			brand_dropdown = [role];

		}
		else if (role == "FMCL" || role == "FMCL KD")
		{
			$('.employee_role').prop("disabled", false);
			brand_dropdown = ["FMCL","FMCL KD"];
		}
		else
		{
			$('.employee_role').prop("disabled", false);
			brand_dropdown = ["FMCL","WWCVL","FMCL KD","KD","ALL"];
		}
		
			
					for(kl=0;kl<brand_dropdown.length;kl++)
					{
				        selectHTML+= "<option value='"+brand_dropdown[kl]+"'>"+brand_dropdown[kl]+"</option>";
					}	
					
					var div = document.getElementById('employee_role');
					while(div.firstChild){
					div.removeChild(div.firstChild);
					}
		document.getElementById('employee_role').innerHTML= selectHTML;	
}
