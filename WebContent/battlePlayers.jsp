<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import = "org.json.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="./materialize/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="./javascript/jquery-3.2.1.min.js"></script>
  <script src="./materialize/js/materialize.min.js"></script>
<title>Battle Arena</title>
</head>
<body>
<p style="display:none;" id="userName" >${name}</p>
<div id="navbar" style="opacity:0;" ></div>
<div class="container" style="opacity:0;" >
<div class="row" >
<div class="col s3" ></div>
<div class="col s9" >
<ul class="collection">
<% 
	JSONArray arr = (JSONArray)request.getAttribute("players");
	for(int i=0;i<arr.length();i++){
		JSONObject temp = arr.getJSONObject(i);
		out.println("<li class=\"collection-item\" >");
		out.println("<div class=\"row\"> <div class=\"col s2 offset-s5\"> <div class=\"card\" > <div class=\"card-image\" > <center><img style=\"height:2cm;width:2cm;\" src=\""+temp.getString("avatar")+"\" ></center> </div> <div class=\"card-content\" > <h6 class=\"indigo-text center\"><strong>"+temp.getString("nickname")+"</strong></h6> </div> </div> </div> </div>");
		out.println("<div class=\"row\">");
		JSONArray t1 = (JSONArray)temp.get("pokemons_caught");
		for(int j=0;j<t1.length();j++){
			JSONObject t2 = t1.getJSONObject(j);
			if(t2.getInt("teamposition")==1){
				out.println("<div class=\"col s2\">");
				out.println("<div class=\"card\">");
				out.println("<div class=\"card-image\">");
				out.println("<center><img style=\"height:2cm;width:2cm;\" src=\"./Pokemons/front/"+t2.getString("pid")+".png\"></center>");
				out.println("</div>");
				out.println("<div class=\"card-content\">");
				out.println("<h6 style=\"font-size:10px\" class=\"center indigo-text\"><strong>"+t2.getString("name")+"<br>L"+t2.getInt("level")+" </strong></h6>");
				out.println("</div>");
				out.println("</div>");
				out.println("</div>");	
			}
		}
		out.println("</div>");
		out.println("<p class=\"center\" ><button id=\""+temp.getString("player_id")+"\" class=\"indigo battleTrainer waves-effect waves-light btn\" >Battle this trainer</button></p>");
		out.println("</li>");
	}
%>
</ul>
</div>
</div>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$("#battlePlayer").addClass("active");
			$("#navbar").css({opacity:"1"});
			$(".container").animate({opacity:"1"},1000);
		});
		$(".battleTrainer").click(function(){
			alert($(this).attr("id"));
		});
	});
</script>
</html>