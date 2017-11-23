<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.json.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="./materialize/css/materialize.min.css">
 <link rel="stylesheet" href="./DataTables/datatables.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="./javascript/jquery-3.2.1.min.js"></script>
  <script type="text/javascript" src="./DataTables/datatables.min.js"></script>
  <script src="./materialize/js/materialize.min.js"></script>
<title>Profile</title>
</head>
<body>
<% JSONObject json = (JSONObject)request.getAttribute("player"); %>
<p style="display:none;" id="userName" ><% out.println(json.getString("name")); %></p>
<div id="navbar" style="opacity:0;" ></div>
<div class="container" >
<div  id="profile_content" style="opacity:0;" >
<h4 class="indigo-text" >Pokemon Team</h4>
<div class="row" >
<% 
for(int i=0;i<6;i++){
	String id="\"pokemon"+(i+1)+"\"";	
    out.println("<div class=\"col s2\"><div class=\"card\"><div id="+id+" style=\"visibility:hidden;\"><div class=\"card-image\"><img style=\"height:100px\" src=\"./Pokemons/front/1.png\"></div><div class=\"card-content\"><h6 class=\"indigo-text\" ><strong>Bulbasaur</strong></h6><p>#Partner : 1</p><p>Level : 10</p><p>HP : 100/100</p><a class=\"rmteam red-text\" href=\"#\" >Remove</a></div></div></div></div>");
}
%>
</div>
<div class="row" >
<div class="col s2 offset-s5" >
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
</div>
<div class="divider" ></div>
<h4 class="indigo-text" >Pokemons Caught</h4>
<div id="table_div">
<table id="myTable" class="display" cellspacing="0" width="100%" >
<thead>
<tr>
<th>#Partner</th>
<th>PID</th>
<th>Name</th>
<th>Image</th>
<th>Type</th>
<th>Level</th>
</tr>
</thead>
<tbody>
<%
JSONArray arr = (JSONArray)json.get("pokemons_caught");
for(int i=0;i<arr.length();i++){
	JSONObject temp = arr.getJSONObject(i);
	String source = "./Pokemons/front/"+temp.getString("pid")+".png";
	out.println("<tr><td>"+temp.getString("uid")+"</td><td>"+temp.getString("pid")+"</td><td>"+temp.getString("name")+"</td><td><img class=\"responsive-img \" src=\" "+source+" \" ></td><td><ul>");
	String[] s = (String[])temp.get("types");
	for(int j=0;j<s.length;j++){
		out.println("<li>"+(j+1)+") "+s[j]+"</li>");
	}
	out.println("</ul></td><td>"+temp.getInt("level")+"</td></tr>");
}
%>
</tbody>
</table>
</div>
  <div id="modal1" class="modal">
    <div class="modal-content">
    <div class="row" >
    <div class="col s2" ><h5 id="pokename" class="indigo-text" >Name</h5><img id="pokeimg" class="responsive-img" alt="No-img" src="./Pokemons/front/1.png"></div>
    <div class="col s1"></div>
    <div class="col s3" >
      <p id="Partner" >1</p>
      <p id="PokeID" >465</p>
      <p id="Level">102</p>
      <p id="exp">102</p>    
      <p id="BaseHP">Alvin</p>
      <p id="BaseAttack">Alvin</p>
      <p id="BaseSpeed">Alvin</p>
      <p id="BaseDefence">Alvin</p>
      <a id="evolve" style="display:none;" href="#">Evolve !</a>
      <a id="addteam" href="#" class="indigo-text">Add to my team</a>
    </div>
    <div id="CurrMoves" class="col s3">
    <h6  class="indigo-text">Attacks</h6>
    </div>
    <div id="AvailableMoves" class="col s3">
    <h6 class="indigo-text">Available Attacks</h6>
    </div>
    </div>
    </div>
  </div>
</div>
</div>
</body>
<script type="text/javascript">
	function fillTeam(res){
		var i;
		for(i=0;i<res.length;i++){
			var id = "#pokemon"+(i+1);
			var c1 = $(id).children();
			$(c1[0]).children("img").attr("src","./Pokemons/front/"+res[i].pid+".png")
			var c2 = $(c1[1]).children();
			$(c2[0]).children("strong").text(res[i].name);
			$(c2[1]).text("#Partner : "+res[i].uid);
			$(c2[2]).text("Level : "+res[i].level);
			$(c2[3]).text("HP : "+res[i].currenthp+"/"+res[i].basehp);
			$(id).css("visibility","visible");
		} 
		for(i=res.length;i<6;i++){
			var id = "#pokemon"+(i+1);
			$(id).css("visibility","hidden");
		}
	}
	
	function fillMoves(currMoves,availableMoves,uid){
		$("#CurrMoves").html("<h6 class=\"indigo-text\">Attacks</h6>");
		$("#AvailableMoves").html("<h6 class=\"indigo-text\">Available Attacks</h6>");
		var i;
		for(i=0;i<currMoves.length;i++){
			$("#CurrMoves").append("<a class=\"KnownMoves\" href=\"#\" >"+currMoves[i].A_ID+" "+currMoves[i].A_Name+"</a><br>");
		}
		for(i=0;i<availableMoves.length;i++){
			$("#AvailableMoves").append("<a class=\"UnknownMoves\" href=\"#\">"+availableMoves[i].A_ID+" "+availableMoves[i].A_Name+"</a><br>");
		}
		$(".KnownMoves").click(function(event){
			event.preventDefault();		
			$.post("Profile",{"function":"rm known move","uid":uid,"A_ID":$(this).text()},function(data){
				var res = JSON.parse(data);
				if(res.success){
					fillMoves(res.CurrMoves,res.AMoves,uid);	
				}
			});
		});
		$(".UnknownMoves").click(function(event){
			event.preventDefault();
			$.post("Profile",{"function":"add known move","uid":uid,"A_ID":$(this).text()},function(data){
				var res = JSON.parse(data);
				if(res.success){
					fillMoves(res.CurrMoves,res.AMoves,uid);	
				}
			});
		});
	}
	
	$(document).ready(function(){
		$('.modal').modal({complete:function(){
			$("#evolve").css("display","none");
		}});
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$.post("Profile",{"function":"Get team info"},function(data){
				var res = JSON.parse(data);
				fillTeam(res);
				$("#navbar").css({opacity:"1"});
				$("#profile_content").animate({opacity:"1"},1000);
			});
		});
		var table = $('#myTable').DataTable({"lengthChange":false});
		$("#myTable tbody").on('click','tr',function(){
			var c = table.row(this).data();
			$.post("Profile",{"function":"Get pokemon stats","uid":c[0]},function(data){
				var res = JSON.parse(data);
				$("#Partner").text("#Partner : "+c[0]);
				$("#PokeID").text("Pokemon ID : "+c[1]);
				$("#pokename").text(res.Name);
				$("#Level").text("Level : "+res.Level);
				$("#exp").text("Exp : "+res.Exp);
				$("#pokeimg").attr({"src":"./Pokemons/front/"+c[1]+".png"});
				$("#BaseHP").text("CurrHP : " + res.currHP+"/"+res.MaxHP);
				$("#BaseAttack").text("Attack : " + res.Attack);
				$("#BaseSpeed").text("Speed : " + res.Speed);
				$("#BaseDefence").text("Defence : " + res.Defence);
				var currMoves = res.CurrentMoves;
				var availableMoves = res.AvailableMoves;
				fillMoves(currMoves,availableMoves,c[0]);
				if(res.EvolveAvailable){
					$("#evolve").css("display","block");
				}
				$("#modal1").modal("open");
			});
		});
		$("#addteam").click(function(event){
			event.preventDefault();
			var c = $("#addteam").siblings("#Partner").text();
			$.post("Profile",{"function":"Add to my team","uid":c},function(data){
				var res = JSON.parse(data);
				fillTeam(res);
			});
		});
		$("#evolve").click(function(){
			event.preventDefault();			
			$.post("Profile",{"function":"Evolve pokemon","uid":$("#Partner").text()},function(data){
				var res = JSON.parse(data);
				if(res.success){
					location.reload();	
				}				
			});
		});
		$(".rmteam").click(function(event){
			event.preventDefault();
			var c = $(this).siblings("p").first().text();
			$.post("Profile",{"function":"Remove from my team","uid":c},function(data){
				var res = JSON.parse(data);
				fillTeam(res);
			});
		});
	});
</script>
</html>