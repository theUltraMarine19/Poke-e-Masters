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

<p style="display:none;" id="userName" >${name}</p>
<div id="navbar"></div>
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
#container {
    position:relative;
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
<div>
	<div id="container">
		<center><img src="./Pokemons/back/1.png" id="img1"></center>
		<%
		int wildId = Integer.parseInt(request.getParameter("wildId"));
		out.println("<center><img src=\"./Pokemons/front/"+wildId+".png\" id=\"img2\"></center>");
		%>
	</div>
	<div style="float: left;">
		<p id="p1"></p>
	</div>
</div>
</body>
</html>