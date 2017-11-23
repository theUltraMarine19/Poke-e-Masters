<%@page import="java.io.FileInputStream"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.io.InputStreamReader"%>
<%@page import="java.io.File"%>
<%@page import="java.io.FileReader"%>
<%@page import="java.io.BufferedReader"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.json.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="./materialize/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="./javascript/jquery-3.2.1.min.js"></script>
  <script src="./materialize/js/materialize.min.js"></script>
  <style type="text/css">
#battleground {
	position: relative;
    background-image: url('./battle.png');
    width: 400px;
    height: 238px;
}
#img3 {
    position: absolute;
    left: 50px;
    top: 150px;
}
#img4 {
    position: absolute;
    left: 250px;
    top: 70px;
}
.center {text-align: center;}
.tmid {margin: 0px auto;}
</style>
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
		    	$("#panelContent").append("<p>Wild Pokemon appeared!!!<\p><p>Level : 10</p><br>");
		    	$("#panelContent").append("<form id=\"BattleForm\"><input type=\"hidden\" name=\"wildId\" value=\""+wildId+"\"><imput type=\"hidden\" name=\"wildLvl\" value=\"10\"><input type=\"submit\" value=\"Battle\"></form>");
				$("#BattleForm").submit(function(){
					var details = $(this).serialize();
					var wildPoke = $(this).children("input");
					$("#img4").attr({"src":"./Pokemons/front/"+$(wildPoke[0]).val()+".png","alt":"No Image"});
				    $.post("Battle",{"type":"wild","state":"begin","WildPID":$(wildPoke[0]).val(),"Level":"10"},function(data){
						var res = JSON.parse(data);
				    	$("#oppimage").attr("src","./Pokemons/front/"+$(wildPoke[0]).val()+".png");
				    	$("#oppinfo").html("<h6 class=\"indigo-text\"><strong>"+res.name+"</strong></h6><p>#wildID : "+res.wildID+"</p><p>Level : "+res.Level+"</p><p>HP : "+res.currHP+"/"+res.currHP+"</p>");
						$("#modal1").modal("open");
					});	 	 	
					$("#modal1").modal("open");
					return false;
				});
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
	<div class="card" style="display:none;margin-top: 70px;" id="panel">
        <div class="card-image" id="panelImg">
        </div>
        <div class="card-content" id="panelContent">
        </div>
	</div>
</div>
</div>
</div>
  <div id="modal1" class="modal">
    <div class="modal-content">
    <div class="row">
    <div class="col s2 offset-s5" >
    <h5 class="indigo-text" ><strong>Battle</strong></h5>
    </div>
    </div>
    <div id="pokemoves" class="row">	
	</div>
	<div class="row" >
	<div class="col s4" >
	<%
		JSONArray player_team = new JSONArray((String)request.getAttribute("player_team"));
		for(int i=0;i<player_team.length();i++){
			JSONObject temp = player_team.getJSONObject(i);
			String id = "pokemon"+(i+1);
			out.println("<div class=\"row\"><div class=\"col s10\"><div class=\"card hoverable\"><div id="+id+"><div class=\"card-image\"><img style=\"height:100px;\" src=\"./Pokemons/front/"+temp.getString("pid")+".png\"></div><div class=\"card-content\"><h6 class=\"indigo-text\" ><strong>"+temp.getString("name")+"</strong></h6><p>#Partner : "+temp.getString("uid")+"</p><p>Level : "+temp.getInt("level")+"</p><p>HP : "+temp.getInt("currenthp")+"/"+temp.getInt("basehp")+"</p><p style=\"display:none;\">"+temp.getString("pid")+"</p></div></div></div></div></div>");
		}
	%>
	</div>
	<div class="col s5">
	</div>
	<div class="col s3">
	<div class="card">
	<div class="card-image">
	<img style="height:100px;" alt="No Image" id="oppimage" src="./Pokemons/front/1.png">
	</div>
	<div id="oppinfo" class="card-content">
	<h6 class="indigo-text"><strong>wildid</strong></h6>
	<p>wildid</p>
	<p>wildid</p>
	</div>
	</div>
	</div>
	</div>
    </div>
  </div>
</body>
<script type="text/javascript">

	$(document).ready(function(){
		$("#modal1").modal({complete:function(){
			numSteps=0;
		    $("#panel").hide();
		    $("#panelImg").html("");
		    $("#panelContent").html("");
		    $("#pokemoves").html("");
		}});
		$("#navbar").load("navbar1.html",function(){
			$("#name_user").text($("#userName").text());
			$('#cities').addClass('active');
			$(".dropdown-button").dropdown();
		});
		var i;
		for(i=0;i<6;i++){
			var id = "#pokemon"+(i+1);
			$(id).click(function(){
				alert("selected pokemon");
				var c = $(this).children(".card-content").first().children("p");
				$.post("Profile",{"function":"Get pokemon moves","uid":$(c[0]).text()},function(data){
					var res = JSON.parse(data);
					$("#pokemoves").html("<div class=\"col s2\" ></div>");
					var i;
					for(i=0;i<res.length;i++){
						var a_id = "attack"+(i+1);
						$("#pokemoves").append("<div class=\"col s2\"><div class=\"card hoverable\"><div id=\""+a_id+"\" class=\"card-content\"><p style=\"font-size:10px;\">#"+res[i].AttackID+" "+res[i].Name+"</p><p style=\"font-size:10px;\">PP : "+res[i].PP+"</p></div></div></div>");
						$("#"+a_id).click(function(){
							
						});
					}
				});
			});
		}
	});
</script>
</html>
