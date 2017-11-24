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
  <!-- <script> var src_avatar;
  		   var src_badge;
  		   var src_name;
  		   var src_num_pokemon; </script>
 -->

<title>Admin Interface</title>
<style>
ul li {
    display:inline;
}
</style>
</head>
<body>
<div class="container" style="opacity:0;" >
<br>
<div class="row" >
<p class = "flow-text"> Welcome to the Admin Interface</p>
</div>
<br>
<div class="row" >
<div class="col s4 offset-s1" >
<a class="waves-effect waves-light btn" id = "gym"><i class="material-icons right">edit</i>Create New Gym Master</a>
</div>
</div>
<div class="row">
<div class="col s4 offset-s1" >
<a class="waves-effect waves-light btn" id = "map"><i class="material-icons right">edit</i>Modify Map</a>
</div>
</div>
<div class="row">
<div class="col s4 offset-s1" >
<a class="waves-effect waves-light btn" id = "logout">Logout</a>
</div>
</div>
</div>
</body>
<script>
$(document).ready(function(){
	$(".container").animate({opacity:"1"},1500);

	$("#gym").click(function(){
		$.post("Admin",{"function":"selection","choice":"gymLeader"},function(data){
			var res = JSON.parse(data);
			if(res.success){
				window.location.replace("gymLeader");
			}
			else{
				alert("Sorry, something went wrong try again");
			}

		});
	});
	$("#map").on('click',function(){
	    window.location = "CreateMap";
		});
	$("#logout").on('click',function(){
	    window.location = "Logout";
		});

	});
</script>
</html>