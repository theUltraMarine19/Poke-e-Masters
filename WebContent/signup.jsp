<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<title>Signup</title>
</head>
<body>
<div class="container" style = "margin-top: 20px;opacity:0;">

<form method = "post" id = "signup_form" >
<div class ="row" >
<div class="input-field col s6">
<input id = "first_name" name="first_name" type = "text" class="validate" required>
<label for="first_name">First name</label>
</div>
<div class="input-field col s6">
<input id = "last_name" name="last_name" class="validate" type = "text" required>
<label for="last_name">Last name</label>
</div>
</div>

<div class = "row">
<div class="input-field col s12">
<input id = "user_mail" name="user_mail" class="validate" type = "email" required>
<label for="user_mail">Email</label>
</div>
</div>

<div class = "row">
<div class="input-field col s12">
<input id = "password" name="password" type = "password" pattern=".{8,15}" title="Min 8 characters" class="validate" required>
<label for="password">Password</label>
</div>
</div>


<div class = "row">
<div class="input-field col s12">
<input id = "confirm_password" name="confirm_password" type = "password" class="validate" required>
<label for="confirm_password">Confirm password</label><span id='message'></span>
</div>
</div>

<div class = "row">
<div class="input-field col s12">
<input id = "nick_name" name="nick_name" type = "text" class="validate" title="Only this name will be visible to other users" required>
<label for="nick_name">Nickname</label>
</div>
</div>

<div class = "row">
<div  class ="input-field col s2 offset-s5">
  <button class="btn waves-effect waves-light indigo" type="submit" name="action">Submit
  </button>
</div>
</div>

</form>
</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
	$(".container").animate({opacity:"1"},1500);
    $('select').material_select();
	$('#password, #confirm_password').on('keyup', function () {
	  if ($('#password').val() == $('#confirm_password').val()) {
	    $('#message').html('Matching').css('color', 'green');
	  } else 
	    $('#message').html('Not Matching').css('color', 'red');
	});    
    $('#signup_form').submit(function(){
    	if($('#password').val() == $('#confirm_password').val()){
    		var details = $('#signup_form').serialize();
    		var success;
    		$.post("AddUser",details,function(data){
    			var res = JSON.parse(data);
    			if(res.success){
    				confirm("We have sent you a verification email, follow the link in your email to complete your signup process");
    				success = true;
    				window.location.replace("Login");
    			}
    			else{
    				confirm("unsuccessful");
    				success = false;
    			}
    		});
    		return false;
    	}
    	else{
    		alert("Please confirm your password");
    		return false;
    	}
    });
  });
</script>
</html>