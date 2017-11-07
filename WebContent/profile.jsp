<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.json.JSONObject"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<title>Profile</title>
</head>
<body>
<% JSONObject json = (JSONObject)request.getAttribute("player"); %>
<p style="display:none;" id="userName" ><% out.println(json.getString("name")); %></p>
<div id="navbar" style="opacity:0;" ></div>
<div class="container" >
<div  id="profile_content" style="margin-top:20cm;" >
<div class="row" >
<div class="col s3" ></div>
<div class="col s2" >
	<div class="card hoverable">
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/1.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
        </div>
	</div>
</div>
<div class="col s2" ></div>
<div class="col s2" >
	<div class="card hoverable">
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/2.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
        </div>
	</div>
</div>
</div>
<div class="row" >
<div class="col s1" ></div>
<div class="col s2" >
	<div class="card hoverable">
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/3.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
        </div>
	</div>
</div>
<div class="col s2" ></div>
<div class="col s2" >
	<div class="card hoverable">
        <div class="card-image">
            <img class="responsive-img" style="height:200px;" src=<% out.println(json.getString("avatar")); %> >
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong><% out.println(json.getString("nickname")); %></strong></h6>
           <p>Money : <% out.println(json.getInt("money")); %></p>
           <p>Exp : <% out.println(json.getInt("exp")); %></p>
        </div>
	</div>
</div>
<div class="col s2" ></div>
<div class="col s2" >
	<div class="card hoverable">
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/4.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
        </div>
	</div>
</div>
</div>
<div class="row" >
<div class="col s3" ></div>
<div class="col s2" >
	<div class="card hoverable">
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/5.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
        </div>
	</div>
</div>
<div class="col s2" ></div>
<div class="col s2" >
	<div class="card hoverable">
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/6.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
        </div>
	</div>
</div>
</div>
</div>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$("#navbar").css({opacity:"1"});
			$("#profile_content").animate({marginTop:"0cm"},1000);
		});
	});
</script>
</html>