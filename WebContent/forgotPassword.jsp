<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
  <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<title>Forgot password ?</title>
</head>
<body>
<div class="container" style="opacity:0;" >
<div class="row" style="margin-top:250px;" >
<form id="forgotpassword_form" >
<div class="row">
<div class = "input-field col s4 offset-s4">
<input id="user_mail" name="user_mail" type="email" class="validate" required>
<label for="user_mail">Email</label>
</div>
<div class = "input-field col s2">
<button class="btn waves-effect waves-light indigo" style="margin-top:10px;" type="submit" name="action">Submit</button>
</div>
</div>
</form>
</div>
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$(".container").animate({opacity:"1"});
	$('#forgotpassword_form').submit(function(){
		var details = $('#forgotpassword_form').serialize(); 
		$.post('ForgotPassword',details,function(data){
			var res = JSON.parse(data);
			if(res.success){
				alert(res.status);
				window.location.replace("Login");
			}
			else{
				alert("Email does not exist in our database");
			}
		});
		return false;
	});
});
</script>
</html>