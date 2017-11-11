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
<div class="col s3" ></div>
<div class="col s2" >
	<div class="card hoverable">
	<div id="pokemon1"  style="visibility:hidden;" >
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/1.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
        <p>a</p>
        <p>b</p>
        <p>c</p>
        </div>
	</div>
	</div>
</div>
<div class="col s2" ></div>
<div class="col s2" >
	<div class="card hoverable">
	<div id="pokemon2" style="visibility:hidden;">
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/2.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
         <p>a</p>
        <p>b</p>
        <p>c</p>
        </div>
	</div>
	</div>
</div>
</div>
<div class="row" >
<div class="col s1" ></div>
<div class="col s2" >
	<div class="card hoverable">
    <div id="pokemon3" style="visibility:hidden;" >
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/3.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
         <p>a</p>
        <p>b</p>
        <p>c</p>
        </div>
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
    <div id="pokemon4" style="visibility:hidden;" >
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/4.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
         <p>a</p>
        <p>b</p>
        <p>c</p>
        </div>
	</div>
	</div>
</div>
</div>
<div class="row" >
<div class="col s3" ></div>
<div class="col s2" >
	<div class="card hoverable">
	<div id="pokemon5" style="visibility:hidden" >
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/5.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
        <p>a</p>
        <p>b</p>
        <p>c</p>
        </div>
	</div>
	</div>
</div>
<div class="col s2" ></div>
<div class="col s2" >
	<div class="card hoverable">
     <div id="pokemon6" style="visibility:hidden" >
        <div class="card-image">
            <img style="height:100px;" src="./Pokemons/front/6.png">
        </div>
        <div class="card-content">
        <h6 class="indigo-text" ><strong>Charizard</strong></h6>
         <p>a</p>
        <p>b</p>
        <p>c</p>
        </div>
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
<th>#PokemonPartner</th>
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
</div>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$.post("Profile",{"function":"Get team info"},function(data){
				var res = JSON.parse(data);
				var i;
				for(i=0;i<res.length;i++){
					var id = "#pokemon"+(i+1);
					$(id).children(".card-image").html("<img style=\"height:100px;\" src=\"./Pokemons/front/"+res[i].pid+".png\">");
					$(id).children(".card-content").html( "<h6 class=\"indigo-text\" ><strong>"+res[i].name+"</strong></h6><p>#Partner : "+res[i].uid+"</p><p>Level : "+res[i].level+"</p><p>HP : "+res[i].currenthp+"/"+res[i].basehp+"</p>");
					$(id).css({"visibility":"visible"});
				} 
				$("#navbar").css({opacity:"1"});
				$("#profile_content").animate({opacity:"1"},1000);
			});
		});
		$('#myTable').DataTable({"lengthChange":false});
	});
</script>
</html>