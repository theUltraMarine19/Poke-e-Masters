<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<title>Login</title>
</head>
<body>
<div class="container">
<div class="row" style="margin-top:200px;">
<form action="">
<div class = "input-field col s4 offset-s4">
<input id="user_name" type="text" class="validate">
<label for="user_name">Username</label>
</div>
<div class="input-field col s4 offset-s4">
<input id="password" type="password" class="validate">
<label for="password">Password</label>
</div>
<div class="col s2 offset-s5">
<a class="waves-effect waves-light btn">Login</a>
</div>
<div class="col s3 offset-s5" style="margin-top:15px">
<a href="signup.jsp" class="waves-effect waves-light btn">Signup</a>
</div>
</form>
</div>
</div>
</body>
</html>