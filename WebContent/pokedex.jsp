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
<title>Pokedex</title>
</head>
<body>
<p style="display:none;" id="userName" >${name}</p>
<div id="navbar" style="opacity:0;" ></div>
<div class="container" style="opacity:0;">
<div id="table_div">
<table id="myTable" class="display" cellspacing="0" width="100%" >
<thead>
<tr>
<th>PID</th>
<th>Name</th>
<th>Image</th>
<th>Types</th>
</tr>
</thead>
<tbody>
<%
JSONArray arr = (JSONArray)request.getAttribute("pokemons");
for(int i=0;i<arr.length();i++){
	JSONObject json = (JSONObject)arr.get(i);
	String source = "./Pokemons/front/"+json.getString("pid")+".png";
	out.println("<tr><td>"+json.getString("pid")+"</td><td>"+json.getString("name")+"</td><td><img class=\"responsive-img \" src=\" "+source+" \" ></td><td><ul>");
	String[] s = (String[])json.get("types");
	for(int j=0;j<s.length;j++){
		out.println("<li>"+(j+1)+") "+s[j]+"</li>");
	}
	out.println("</ul></td></tr>");
}
%>
</tbody>
</table>
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
      <p id="Evolveid">Alvin</p>
      <p id="Evolvelevel">Alvin</p>
    </div>
    <div id="pokeAttacks" class="col s4">
    <h6 class="indigo-text" ><strong>Available Attacks</strong></h6>
    </div>
    </div>
    </div>
  </div>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$('.modal').modal();
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$('#pokedex').addClass('active');
			$("#navbar").css({opacity:"1"});
			$(".container").animate({opacity:"1"},1000);
		});
		var table = $('#myTable').DataTable({"lengthChange":false});
		$("#myTable tbody").on('click','tr',function(){
			var c = table.row(this).data();
			$.post("Pokedex",{"pid":c[0]},function(data){
				var res = JSON.parse(data);
				if(res.success){
					$("#pokename").text(res.name);
					$("#pokeimg").attr({"src":"./Pokemons/front/"+res.pid+".png"});
					$("#BaseHP").text("BaseHP : " + res.BaseHP);
					$("#BaseAttack").text("BaseAttack : " + res.BaseAttack);
					$("#BaseSpeed").text("BaseSpeed : " + res.BaseSpeed);
					$("#BaseDefence").text("BaseDefence : " + res.BaseDefence);
					$("#Types").text("Type : " + res.Types);
					if(res.MinEvolveLevel!="0"){
						$("#Evolveid").text("Evolves Into : #"+res.EvolveIntoID);
						$("#Evolvelevel").text("Evolution level : "+res.MinEvolveLevel);
					}
					else{
						$("#Evolveid").text("Evolves Into : None");
						$("#Evolvelevel").text("");
					}				
					var attacks = res.Attacks;
					var i;
					$("#pokeAttacks").html("<h6 class=\"indigo-text\"><strong>Available Attacks</strong></h6>");
					for(i=0;i<attacks.length;i++){
						$("#pokeAttacks").append("<p>"+attacks[i].A_ID+" "+attacks[i].A_Name+"</p>");
					}
					$("#modal1").modal("open");	
				}
			});
		});
	});
</script>
</html>