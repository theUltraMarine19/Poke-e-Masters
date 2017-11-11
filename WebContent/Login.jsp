<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="./materialize/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="./javascript/jquery-3.2.1.min.js"></script>
  <script src="./materialize/js/materialize.min.js"></script>
<title>Login</title>
</head>
<body>
<div class="container" style="opacity:0;" >
<div class="row" style="margin-top:200px;">
<form id="login_form">
<div class="row">
<div class = "input-field col s4 offset-s4">
<input id="user_mail" name="user_mail" type="email" class="validate" required>
<label for="user_mail">Email</label>
</div>
</div>
<div class="row">
<div class="input-field col s4 offset-s4">
<input id="password" name="password" type="password" pattern=".{8,15}" title="Min 8 characters" class="validate" required>
<label for="password">Password</label>
</div>
<div class= "col s2" style="margin-top:48px;"><a href="ForgotPassword">Forgot password ?</a></div>
</div>
<div class = "row">
<div  class ="input-field col s2 offset-s5">
  <button class="btn waves-effect waves-light indigo" style="margin-left:8px;" type="submit" name="action">Login</button>
</div>
</div>
</form>
</div>
<div class="row" >
<div class="col s3 offset-s5" style="margin-top:15px">
<a href="AddUser" class="waves-effect waves-light btn indigo">Signup</a>
</div>
</div>
</div>
<script type="text/javascript">
$(document).ready(function(){
	$(".container").animate({opacity:"1"},1500);
	$('#login_form').submit(function(){
		var details = $('#login_form').serialize();
		var success;
		$.post('Login',details,function(data){
			var obj = JSON.parse(data);
			success = obj.success;
			if(success){
				alert(obj.status+" "+obj.userid);
				window.location.replace("Home");
			}
			else{
				alert(obj.status);	
			}
		});
		return false;
	});
});
</script>
</body>
</html>