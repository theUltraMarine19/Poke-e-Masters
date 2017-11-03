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
<div class="container" style = "margin-top: 20px;">

<form method = "post" id = "signup_form">
<div class ="row" >
<div class="input-field col s6">
<input id = "first_name" name="first_name" type = "text" required="true">
<label for="first_name">First name</label>
</div>
<div class="input-field col s6">
<input id = "last_name" name="last_name" type = "text" required="true">
<label for="last_name">Last name</label>
</div>
</div>

<div class = "row">
<div class="input-field col s12">
<input id = "user_mail" name="user_mail" type = "email" required="true">
<label for="user_mail">Email</label>
</div>
</div>

<div class = "row">
<div class="input-field col s12">
<input id = "password" name="password" type = "password" pattern=".{8,16}" title="Min 8 characters" required="true">
<label for="password">Password</label>
</div>
</div>


<div class = "row">
<div class="input-field col s12">
<input id = "confirm_password" name="confirm_password" type = "password" required="true">
<label for="confirm_password">Confirm password</label><span id='message'></span>
</div>
</div>

<div class = "row">
<div class="input-field col s12">
<input id = "nick_name" name="nick_name" type = "text" title="Only this name will be visible to other users" required="true">
<label for="nick_name">Nickname</label>
</div>
</div>

<div class = "row">
<div  class ="input-field col s2 offset-s5">
  <button class="btn waves-effect waves-light" type="submit" name="action">Submit
  </button>
</div>
</div>

</form>
</div>
</body>
<script type="text/javascript">
$(document).ready(function() {
    $('select').material_select();
	$('#password, #confirm_password').on('keyup', function () {
	  if ($('#password').val() == $('#confirm_password').val()) {
	    $('#message').html('Matching').css('color', 'green');
	  } else 
	    $('#message').html('Not Matching').css('color', 'red');
	});    
    $('#signup_form').submit(function(){
    	var str=$('#message').val().toString();
    	if($('#password').val() == $('#confirm_password').val()){
    		var details = $('#signup_form').serialize();
    		$.post("AddUser",details,function(data){
    			alert("Response from server : "+data);
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