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
<script type="text/javascript">
	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$('#cities').addClass('active');
		});
	});
</script>

<style type="text/css">
#cont {
    position:relative;
    left: 300px;
    top: 60px;
    float: left;
    background-image: url('./battle.png');
    width: 400px;
    height: 238px;
    
}
#img1 {
    position: absolute;
    left: 50px;
    top: 150px;
}
#img2 {
    position: absolute;
    left: 250px;
    top: 70px;
}
.center {text-align: center;}
.tmid {margin: 0px auto;}
</style>
<body>

<p style="display:none;" id="userName" >${name}</p>
<div id="navbar"></div>
<div>
	<div id="cont">
		<img src="./Pokemons/back/1.png" id="img1">
		<div class="center tmid" ><img src="./Pokemons/front/6.png" id="img2"></div>
	</div>
	<div style="float: left;">
		<p id="p1"></p>
	</div>
</div>
</body>
</html>