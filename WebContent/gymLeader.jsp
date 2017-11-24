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
  <script> var src_avatar = 0;
  		   var src_name;
  		   var src_city;
  		   var src_badge = 0;
  		   var src_p1 = 0;
  		   var src_p2 = 0;
  		   var src_p3 = 0;
  		   var src_p4 = 0;
  		   var src_p5 = 0;
  		   var src_p6 = 0;
  		   var ctr = 0;
  		   </script>


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
<h4 class="indigo-text" >Choose Pokemon Levels</h4>
</div>
</div>

<div class ="row" >
<div class="input-field col s6">
<input id = "levelp1" name="levelp1" type = "text" class="validate">
<label for="levelp1">Pokemon 1</label>
</div>
<div class="input-field col s6">
<input id = "levelp2" name="levelp2" type = "text" class="validate">
<label for="levelp2">Pokemon 2</label>
</div>
<div class="input-field col s6">
<input id = "levelp3" name="levelp3" type = "text" class="validate">
<label for="levelp3">Pokemon 3</label>
</div>
<div class="input-field col s6">
<input id = "levelp4" name="levelp4" type = "text" class="validate">
<label for="levelp4">Pokemon 4</label>
</div>
<div class="input-field col s6">
<input id = "levelp5" name="levelp5" type = "text" class="validate">
<label for="levelp5">Pokemon 5</label>
</div>
<div class="input-field col s6">
<input id = "levelp6" name="levelp6" type = "text" class="validate">
<label for="levelp6">Pokemon 6</label>
</div>

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
    out.println("<div class=\"col s2\"><div class=\"card\"><div id="+id+" style=\"visibility:hidden;\"><div class=\"card-image\"><img style=\"height:100px\" src=\"./Pokemons/front/1.png\"></div><div class=\"card-content\"></div></div></div></div>");
}
%>
</div>

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
      <p id="Partner" >1</p>
      <p id="PokeID" >465</p>
      <p id="BaseAttack">Alvin</p>
      <p id="BaseSpeed">Alvin</p>
      <p id="BaseDefence">Alvin</p>
      <p id="Types">Alvin</p>
      <a id="addteam" href="#" class="indigo-text">Add to my team</a>
    
    </div>
    <div id="pokeAttacks" class="col s4">
    <h6 class="indigo-text" ><strong>Available Attacks</strong></h6>
    </div>
    </div>
    </div>
  </div>
<input type="hidden" name="avatar" value="NotSet" id="field1"/>
<input type="hidden" name="badge" value="NotSet" id="field2"/>
<input type="hidden" name="poke1" value="NotSet" id="field3"/>
<input type="hidden" name="poke2" value="NotSet" id="field4"/>
<input type="hidden" name="poke3" value="NotSet" id="field5"/>
<input type="hidden" name="poke4" value="NotSet" id="field6"/>
<input type="hidden" name="poke5" value="NotSet" id="field7"/>
<input type="hidden" name="poke6" value="NotSet" id="field8"//>

<div class = "row">
<div  class ="input-field col s2 offset-s5">
  <button class="btn waves-effect waves-light indigo" type="submit" name="action">Create
  </button>
</div>
</div>
</form>

</div>

</body>
<script>
$(document).ready(function(){
	$('.modal').modal();
	var i;
	for(i=0;i<4;i++){
		$('#first').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+1)+'" class="responsive-img" style="height:150px;" src="./GymLeaders/'+(i+1)+'.png" ></p></div></div>');
		$('#bfirst').append('<div class="col s2" ><div class="card-image hoverable" ><p class="center-align" ><img id="'+(i+1)+'" class="responsive-img" style="height:150px;" src="./Badges/'+(i+1)+'.png" ></p></div></div>');
		$('#second').append('<div class="col s2" ><div class="card-panel hoverable" ><p class="center-align" ><img id="'+(i+5)+'" class="responsive-img" style="height:150px;" src="./GymLeaders/'+(i+5)+'.png" ></p></div></div>');
		$('#bsecond').append('<div class="col s2" ><div class="card-image hoverable" ><p class="center-align" ><img id="'+(i+5)+'" class="responsive-img" style="height:150px;" src="./Badges/'+(i+5)+'.png" ></p></div></div>');
	}
	
	$(".container").animate({opacity:"1"},1500);
	var table = $('#myTable').DataTable({"lengthChange":false});
	// function fillTeam(res){
	// 	var i;
	// 	for(i=0;i<res.length;i++){
	// 		var id = "#pokemon"+(i+1);
	// 		var c1 = $(id).children();
	// 		$(c1[0]).children("img").attr("src","./Pokemons/front/"+res[i].pid+".png")
	// 		var c2 = $(c1[1]).children();
	// 		$(c2[0]).children("strong").text(res[i].name);
	// 		$(c2[1]).text("#Partner : "+res[i].uid);
	// 		$(c2[2]).text("Level : "+res[i].level);
	// 		$(c2[3]).text("HP : "+res[i].currenthp+"/"+res[i].basehp);
	// 		$(id).css("visibility","visible");
	// 	} 
	// 	for(i=res.length;i<6;i++){
	// 		var id = "#pokemon"+(i+1);
	// 		$(id).css("visibility","hidden");
	// 	}
	// }


		$("#myTable tbody").on('click','tr',function(){
			var c = table.row(this).data();
			$.post("Pokedex",{"pid":c[0]},function(data){
				var res = JSON.parse(data);
				if(res.success){
					$("#pokename").text(res.name);
					$("#Partner").text("#Partner : "+res.pid);
					$("#PokeID").text("Pokemon ID : "+res.pids);
					$("#pokeimg").attr({"src":"./Pokemons/front/"+res.pid+".png"});
					$("#BaseHP").text("BaseHP : " + res.BaseHP);
					$("#BaseAttack").text("BaseAttack : " + res.BaseAttack);
					$("#BaseSpeed").text("BaseSpeed : " + res.BaseSpeed);
					$("#BaseDefence").text("BaseDefence : " + res.BaseDefence);
					$("#Types").text("Type : " + res.Types);
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


		$("#addteam").click(function(event){
			event.preventDefault();			
			var c = $("#addteam").siblings("#Partner").text().split(" ")[2];
			var id = "#pokemon"+(ctr+1);
			var c1 = $(id).children();
			var x = ctr + 3;
			document.getElementById("field"+x).value = c;
		
			$(c1[0]).children("img").attr("src","./Pokemons/front/"+c+".png");
			$(id).css("visibility","visible");
			ctr++;
			});
			
		// $(".rmteam").click(function(event){
		// 	event.preventDefault();
		// 	var c = $(this).siblings("p").first().text();
		// 	fillTeam(res);
			
		// });

			
	$(".card-panel").click(function(){	
		src_avatar = $(this).children("p").children("img").attr("id");
		$(this).css("z-index", "10");
		document.getElementById("field1").value = src_avatar;
		$(this).addClass("z-depth-5");
		// alert(this);
		
	});

	$(".card-image").click(function(){	
		src_badge = $(this).children("p").children("img").attr("id");
		$(this).css("z-index", "10");
		document.getElementById("field2").value = src_badge;
		$(this).addClass("z-depth-5");
		// alert(this);
		
	});

	$('#gymLeader_form').submit(function(){
    		var details = $('#gymLeader_form').serialize();
    		alert(details);
    		var success;
    		$.post("gymLeader",details,function(data){
    			alert(data);
    			var res = JSON.parse(data);
    			if(res.success){
    				confirm("New Gym Leader Created!");
    				success = true;
    				window.location.replace("Admin");
    			}
    			else{
    				confirm("unsuccessful");
    				success = false;
    			}
    		});
    		return false;
    	
    	
    });

});
</script>
</html>