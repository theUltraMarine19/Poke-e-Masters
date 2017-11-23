<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="./materialize/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="./javascript/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="./DataTables/datatables.min.js"></script>
  <script src="./materialize/js/materialize.min.js"></script>
<title>Create Gym Leader</title>
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
<h4 class="indigo-text" >Choose Gym Leader Name</h4>
</div>
</div>

<form method = "post" id = "gymLeader_form" >
<div class ="row" >
<div class="input-field col s6">
<input id = "first_name" name="first_name" type = "text" class="validate" required>
<label for="first_name">First name</label>
</div>
<div class="input-field col s6">
<input id = "city_name" name="city_name" class="validate" type = "text" required>
<label for="city_name">Gym City</label>
</div>
</div>
</form>


<div class="row" >
<div class="col s4 offset-s4" >
<h4 class="indigo-text" >Choose Gym Avatar</h4>
</div>
</div>
<div class="row" id="first">
<div class="col s1" ></div>
</div>
<div class="row" id="second" >
<div class="col s1" ></div>
</div>

<div class="row" >
<div class="col s4 offset-s4" >
<h4 class="indigo-text" >Choose Gym Badge</h4>
</div>
</div>
<div class="row" id="bfirst">
<div class="col s1" ></div>
</div>
<div class="row" id="bsecond" >
<div class="col s1" ></div>
</div>

<div class="row" >
<div class="col s7 offset-s4" >
<h4 class="indigo-text" >Choose Gym Pokemon</h4>
</div>
</div>

<div class="row" >
<% 
for(int i=0;i<6;i++){
	String id="\"pokemon"+(i+1)+"\"";	
    out.println("<div class=\"col s2\"><div class=\"card\"><div id="+id+" style=\"visibility:hidden;\"><div class=\"card-image\"><img style=\"height:100px\" src=\"./Pokemons/front/1.png\"></div><div class=\"card-content\"><h6 class=\"indigo-text\" ><strong>Bulbasaur</strong></h6><p>#Partner : 1</p><p>Level : 10</p><p>HP : 100/100</p><a class=\"rmteam red-text\" href=\"#\" >Remove</a></div></div></div></div>");
}
%>
</div>

<div id="modal1" class="modal">
    <div class="modal-content">
    <div class="row" >
    <div class="col s1" ></div>
    <div class="col s2" ><h5 id="pokename" class="indigo-text" >Name</h5><img id="pokeimg" class="responsive-img" alt="No-img" src="./Pokemons/front/1.png"></div>
    <div class="col s1" ></div>
    <div class="col s4" >
    <h6 class="indigo-text" ><strong>Stats</strong></h6>
      <p id="BaseHP">Alvin</p>
      <p id="BaseAttack">Alvin</p>
      <p id="BaseSpeed">Alvin</p>
      <p id="BaseDefence">Alvin</p>
      <p id="Types">Alvin</p>
    
    </div>
    <div id="pokeAttacks" class="col s4">
    <h6 class="indigo-text" ><strong>Available Attacks</strong></h6>
    </div>
    </div>
    </div>
  </div>

<div class = "row">
<div  class ="input-field col s2 offset-s5">
  <button class="btn waves-effect waves-light indigo" type="submit" name="action">Create
  </button>
</div>
</div>

</div>

</body>
<script>
$(document).ready(function(){
	var i;
	for(i=0;i<5;i++){
		$('#first').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+1)+'" class="responsive-img" style="height:150px;" src="./Avatars/full/'+(i+1)+'.png" ></p></div></div>');
		$('#bfirst').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+1)+'" class="responsive-img" style="height:150px;" src="./Avatars/full/'+(i+1)+'.png" ></p></div></div>');
		$('#second').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+6)+'" class="responsive-img" style="height:150px;" src="./Avatars/full/'+(i+6)+'.png" ></p></div></div>');
		$('#bsecond').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+6)+'" class="responsive-img" style="height:150px;" src="./Avatars/full/'+(i+6)+'.png" ></p></div></div>');
	}
	$('.modal').modal();
	$(".container").animate({opacity:"1"},1500);
	// $(".card-panel").click(function(){	
	// 	var src = $(this).children("p").children("img").attr("id");
	// 	$.post("Home",{"function":"avatar","src":src},function(data){
	// 		var res = JSON.parse(data);
	// 		if(res.success){
	// 			window.location.replace("Home");
	// 		}
	// 		else{
	// 			alert("Sorry, something went wrong try again");
	// 		}
	// 	});
	// });
});
</script>
</html>