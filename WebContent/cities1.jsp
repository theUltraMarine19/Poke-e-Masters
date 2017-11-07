<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
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
<title>Cities</title>
</head>


	<script type="text/javascript">
		var size = 15;
		var dummy = 0;
		<%
		InputStream input = getServletContext().getResourceAsStream("./Maps/map1.txt");
		BufferedReader reader = new BufferedReader(new InputStreamReader(input, "UTF-8"));

        StringBuilder sb = new StringBuilder();
        String line;

        while((line = reader.readLine())!= null){
            sb.append(line+"\n");
        }
        reader.close();
		out.println("var notAllowed = [" + sb.toString() + "];");
		%>
		var numSteps = 0;
		$(document).keydown(function(e)
		{
			var currX = $("#img2").css("left");
			var currY = $("#img2").css("top");
		    switch(e.which)
		    {
		        case 37: // left
		        var nextX = (parseInt(currX.replace(/px/,""))-size)+"px";
		        if (notAllowed.indexOf(nextX+","+currY) <= -1)
		        {
		        	$("#img2").css("left", nextX);
		        }
		        numSteps++;
		        break;

		        case 39: // right
		        var nextX = (parseInt(currX.replace(/px/,""))+size)+"px";
		        if (notAllowed.indexOf(nextX+","+currY) <= -1)
		        {
		        	$("#img2").css("left", nextX);
		        }
		        numSteps++;		        
		        break;

		        case 38: // up
		        var nextY = (parseInt(currY.replace(/px/,""))-size)+"px";
		        if (notAllowed.indexOf(currX+","+nextY) <= -1)
		        {
		        	$("#img2").css("top", nextY);
		        }
		        numSteps++;
		        break;

		        case 40: // down
		        var nextY = (parseInt(currY.replace(/px/,""))+size)+"px";
		        if (notAllowed.indexOf(currX+","+nextY) <= -1)
		        {
		        	$("#img2").css("top", nextY);
		        }
		        numSteps++;
		        break;

		        case 69: //e - print curr position
		        dummy = (dummy+1)%2;
		        break;

		        default: return; // exit this handler for other keys
		    }
		    if (numSteps == 10)
		    {
		    	numSteps = 0;
		    }
		    $("#panel").hide();
		    $("#panelImg").html("");
		    $("#panelContent").html("");
		    if (Math.floor((Math.random() * 10) + 1) < numSteps)
		    {
		    	var wildId = (Math.floor(Math.random() * 200) + 1)*3;
		    	$("#panel").show();
				$("#panelImg").append("<img src=\"./Pokemons/front/"+wildId+".png\" id=\"imgWild\">\n");
		    	$("#panelContent").append("<p>Wild Pokemon appeared!!!<\p><br>");
		    	$("#panelContent").append("<form action=\"Battle\" method=\"post\"><input type=\"hidden\" name=\"wildId\" value=\""+wildId+"\"><input type=\"submit\" value=\"Battle\"></form>");

		    }

		    if (dummy == 1)
		    {
		    	var currX = $("#img2").css("left");
		    	var currY = $("#img2").css("top");
		    	$("#p1").html("'"+currX+","+currY+"',<br>");
		    }
		    e.preventDefault(); // prevent the default action (scroll / move caret)
		});
	</script>
<style type="text/css">
#cont {
    position:relative;
    left: 300px;
    top: 70px;
    float: left;
    background-image: url('./Maps/map1.png');
    width: 464px;
    height: 320px;
    
}
#img2 {
    position: absolute;
    left: 134px;
    top: 185px;
}

</style>
<body>

<p style="display:none;" id="userName" >${name}</p>
<div id="navbar"></div>
	<div id="cont">
		<img src="./Avatars/mini/1.png" id="img2">
	</div>
<div class="container" >
<div class="row" >
<div class="col s6" ></div>
<div class="col s2" >
	<div class="card hoverable" style="display:none;margin-top: 70px;" id="panel">
        <div class="card-image" id="panelImg">
        </div>
        <div class="card-content" id="panelContent">
        </div>
	</div>
</div>
</div>
</div>

</body>
<script type="text/javascript">

	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$("#name_user").text($("#userName").text());
			$('#cities').addClass('active');
			$(".dropdown-button").dropdown();
		});
	});
</script>
</html>
