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

</style>
<body>

<p style="display:none;" id="userName" >${name}</p>
<div id="navbar"></div>
<div>
	<div id="cont">
		<img src="./Pokemons/back/1.png" id="img1">
		<%
		int wildId = Integer.parseInt(request.getParameter("wildId"));
		out.println("<center><img src=\"./Pokemons/front/"+wildId+".png\" id=\"img2\"></center>");
		%>
	</div>
	<div style="float: left;">
		<p id="p1"></p>
	</div>
</div>
<div class="container" >
<div class="row" ></div>
<div class="row" >
<div class="col s2" >
	<div class="card hoverable" style="margin-top: 70px;" id="panel1">
        <div class="card-image" id="panelImg">
        <img style="height:100px;" src="./Pokemons/front/1.png">
        </div>
        <div class="card-content" id="panelContent">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
 
        </div>
	</div>
</div>
<div class="col s2" >
	<div class="card hoverable" style="margin-top: 70px;" id="panel2">
        <div class="card-image" id="panelImg">
        <img style="height:100px;" src="./Pokemons/front/4.png">
        </div>
        <div class="card-content" id="panelContent">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>

        </div>
	</div>
</div>
<div class="col s2" >
	<div class="card hoverable" style="margin-top: 70px;" id="panel3">
        <div class="card-image" id="panelImg">
        <img style="height:100px;" src="./Pokemons/front/7.png">
        </div>
        <div class="card-content" id="panelContent">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>

        </div>
	</div>
</div>
<div class="col s2" >
	<div class="card hoverable" style="margin-top: 70px;" id="panel4">
        <div class="card-image" id="panelImg">
        <img style="height:100px;" src="./Pokemons/front/10.png">
        </div>
        <div class="card-content" id="panelContent">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>

        </div>
	</div>
</div>
<div class="col s2" >
	<div class="card hoverable" style="margin-top: 70px;" id="panel5">
        <div class="card-image" id="panelImg">
        <img style="height:100px;" src="./Pokemons/front/13.png">
        </div>
        <div class="card-content" id="panelContent">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>

        </div>
	</div>
</div>
<div class="col s2" >
	<div class="card hoverable" style="margin-top: 70px;" id="panel6">
        <div class="card-image" id="panelImg">
        <img style="height:100px;" src="./Pokemons/front/16.png">
        </div>
        <div class="card-content" id="panelContent">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
           <p>Level:100</p>
           <p>HP:360/360</p>
        </div>
	</div>
</div>
</div>
</div>
</body>
</html>