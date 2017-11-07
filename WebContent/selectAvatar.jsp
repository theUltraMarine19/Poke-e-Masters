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
<title>Select your avatar</title>
<style>
ul li {
    display:inline;
}
</style>
</head>
<body>
<div class="container" style="opacity:0;" >
<div class="row" >
<div class="col s4 offset-s4" >
<h4 class="indigo-text" >Choose your Avatar</h4>
</div>
</div>
<div class="row" id="first">
<div class="col s1" ></div>
</div>
<div class="row" id="second" >
<div class="col s1" ></div>
</div>
</div>
</body>
<script>
$(document).ready(function(){
	var i;
	for(i=0;i<5;i++){
		$('#first').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+1)+'" class="responsive-img" style="height:150px;" src="./Avatars/full/'+(i+1)+'.png" ></p></div></div>');
		$('#second').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+6)+'" class="responsive-img" style="height:150px;" src="./Avatars/full/'+(i+6)+'.png" ></p></div></div>');
	}
	$(".container").animate({opacity:"1"},1500);
	$(".card-panel").click(function(){
		var src = $(this).children("p").children("img").attr("id");
		$.post("Home",{"function":"avatar","src":src},function(data){
			var res = JSON.parse(data);
			if(res.success){
				window.location.replace("Home");
			}
			else{
				alert("Sorry, something went wrong try again");
			}
		});
	});
});
</script>
</html>