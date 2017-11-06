<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<title>Home</title>
</head>
<body>

<!-- Dropdown Structure -->
<ul id="dropdown1" class="dropdown-content">
  <li><a href="#!">Profile</a></li>
  <li class="divider"></li>
  <li><a href="#">Contact Us</a></li>
  <li class="divider"></li>
  <li><a href="Logout">Logout</a></li>
</ul>
<nav>
  <div class="nav-wrapper indigo">
    <a href="#" style="margin-left: 10px;" class="brand-logo">Pok-E-Masters</a>
    <ul class="right hide-on-med-and-down">
      <li><a href="#">Gym leaders</a></li>
      <li><a href="#">My Pokemon</a></li>
      <!-- Dropdown Trigger -->
      <li><a class="dropdown-button" href="#" data-activates="dropdown1">${name}<i class="material-icons right">arrow_drop_down</i></a></li>
    </ul>
  </div>
</nav>
<div class="container">
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$(".dropdown-button").dropdown();
	});
</script>
</html>