$(document).ready(function(){
	$("#new_user").validate({
		rules:{
			"user[name]" : {required: true, maxlength: 50},
			"user[email]" : {required: true, email: true, remote:"/users/check_email"},
			"user[password]" : {required: true, minlength: 6},
			"user[password_confirmation]" : {required: true, equalTo: "#user_password"}
		}
	});
});

