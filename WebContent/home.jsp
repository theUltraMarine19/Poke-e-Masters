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
<title>Home</title>
</head>
<body>

<p style="display:none;" id="userName" >${name}</p>
<div id="navbar" style="opacity:0;" ></div>

<div class="container" style="opacity:0;" >
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$("#navbar").css({opacity:"1"});
			$(".container").animate({opacity:"1"},1000);
		});
	});
</script>
</html>