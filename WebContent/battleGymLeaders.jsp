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
<title>Gym Battles</title>
</head>
<body>
<% String name = (String)request.getAttribute("name"); %>
<% String num = (String)request.getAttribute("num"); %>
<p style="display:none;" id="userName" ><% out.println(name); %></p>
<div id="navbar" style="opacity:0;" ></div>
<div class="container" >
<div  id="profile_content" style="opacity:0;" >
<h4 class="indigo-text" >Welcome to the Arena of Valor</h4>
<div class="row" >
<% 
for(int i=0;i< Integer.parseInt(num) ;i++){
	String id="\"gyml"+(i+1)+"\"";	
    out.println("<div class=\"col s2\"><div class=\"card\"><div id="+id+" style=\"visibility:hidden;\"><div class=\"card-image\"><img style=\"height:100px\" src=\"./GymLeaders/1.png\"></div><div class=\"card-content\"><h6 class=\"indigo-text\" ><strong>Bulbasaur</strong></h6><p>Santalune City</p><div class=\"divider\"></div><a class=\"battle\" href=\"#\" >Fight</a></div></div></div></div>");
}
%>
</div>
  <div id="modal1" class="modal">
    <div class="modal-content">
    <div class="row">
    <div class="col s2 offset-s5" >
    <h5 class="indigo-text" ><strong>Battle</strong></h5>
    </div>
    </div>
    <div id="gymPokemons" class="row">
    </div>
    <div id="pokemoves" class="row">	
	</div>
	<div id="items" style="display:none;" class="row">		
		<div class="col s1"></div>
		<div class="col s2"><button class="indigo white-text waves-effect item" id="1">Pokeball</button></div>
		<div class="col s2"><button class="indigo white-text waves-effect item" id="2">Megaball</button></div>
		<div class="col s2"><button class="indigo white-text waves-effect item" id="3">S Portion</button></div>
		<div class="col s2"><button class="indigo white-text waves-effect item" id="4">M Portion</button></div>
		<div class="col s2"><button class="indigo white-text waves-effect item" id="5">L Portion</button></div>		
	</div>
	<div class="row" >
	<div class="col s3" >
		<div class="card">
		<div id="selectedpokemon" style="visibility:hidden;">			
			<div class="card-image">
			<img style="height:100px;" alt="No Image" src="./Pokemons/front/1.png">
			</div>
			<div class="card-content">
				<h6 class="indigo-text"><strong>Alvin</strong></h6>
				<p>Alvin</p>
				<p>Alvin</p>
				<p>Alvin</p>
				<p style="display:none;">Alvin</p>					
			</div>			
		</div>
		</div>
	</div>
	<div class="col s6">
	<div id="msg" style="height:200px;overflow-y:scroll"></div>
	</div>
	<div class="col s3">
	<div class="card">
	<div id="opponentpokemon" style="visibility:hidden;" >
	<div class="card-image">
	<img style="height:100px;" alt="No Image" src="./Pokemons/front/1.png">
	</div>
	<div class="card-content">
	<h6 class="indigo-text"><strong>wildid</strong></h6>
	<p>wildid</p>
	<p>wildid</p>
	<p>wildid</p>
	<p style="display:none;">wildid</p>
	</div>
	</div>
	</div>
	</div>
	</div>
	<div id="playerTeam" class="row">	
	
	</div>
    </div>
  </div>
  
</div>
</div>
</body>
<script type="text/javascript">
	var select_apid;
	function fillTeam(res){
		var i;
		for(i=0;i<res.length;i++){
			var id = "#gyml"+(i+1);			
			var c1 = $(id).children();
			$(c1[0]).children("img").attr("src","./GymLeaders/"+res[i].avatar+".png")
			var c2 = $(c1[1]).children();
			$(c2[0]).children("strong").text(res[i].name);
			$(c2[1]).text(res[i].city);
			$(id).css("visibility","visible");
		} 
		
	}
	
	function fillPlayerTeam(res,rowid){
		var i;
		for(i=0;i<res.length;i++){
			var id = rowid +"_"+(i+1); 
			$("#"+rowid).append("<div class=\"col s2\"><div class=\"card hoverable\"><div id="+id+"><div class=\"card-image\"><img style=\"height:100px;\" src=\"./Pokemons/front/"+res[i].pid+".png\"></div><div class=\"card-content\"><h6 style=\"font-size:8px;\" class=\"indigo-text\" ><strong>"+res[i].name+"</strong></h6><p style=\"font-size:small;\">#Partner : "+res[i].uid+"</p><p style=\"font-size:small;\">Level : "+res[i].level+"</p><p style=\"font-size:small;\">HP : "+res[i].currenthp+"/"+res[i].basehp+"</p><p style=\"display:none;\">"+res[i].pid+"</p></div></div></div></div>");
			if(rowid=="playerTeam"&&res[i].currenthp!=0){				
				$("#"+id).click(function(){
					var x = $(this).children(".card-content").children();
					var poketeamno = $(this).attr("id");
					$("#selectedpokemon").children(".card-image").children("img").attr("src","./Pokemons/front/"+$(x[4]).text()+".png");
					var pokeInfo = $("#selectedpokemon").children(".card-content").children();
					$(pokeInfo[0]).children("strong").text($(x[0]).children("strong").text());
					$(pokeInfo[1]).text($(x[1]).text());
					$(pokeInfo[2]).text($(x[2]).text());
					$(pokeInfo[3]).text($(x[3]).text());
					$(pokeInfo[4]).text(poketeamno);
					$.post("Profile",{"function":"Get pokemon moves","uid":$(x[1]).text()},function(data){
						var res = JSON.parse(data);
						$("#pokemoves").html("");
						var i1;						
						for(i1=0;i1<res.length;i1++){
							var a_id = "attack"+(i1+1);
							$("#pokemoves").append("<div class=\"col s3\"><div class=\"card hoverable\"><div id=\""+a_id+"\" class=\"card-content\"><p style=\"font-size:12px;\">#"+res[i1].AttackID+" "+res[i1].Name+"</p><p style=\"font-size:10px;\">PP : "+res[i1].PP+"</p><p style=\"display:none\">"+res[i1].uid+"</p></div></div></div>");	
							if(res[i1].PP==0){
								continue;
							}
							$("#"+a_id).click(function(){
								var attackClick = $(this);
								var a_info = $(this).children("p");
								var attackId = ($(a_info[0]).text()).split(" ")[0];
								$.post("Battle",{"type":"gym","state":"attack","uid":$("#selectedpokemon").children(".card-content").children("p").first().text().split(" ")[2],"a_id":attackId,"apid":select_apid,"ap_pid":$("#opponentpokemon").children(".card-content").children("p").first().text().split(" ")[2]},function(data){
									res = JSON.parse(data);
									if(!res.status){
										alert(data);
									}
									else{
										var history = $("#msg").html();
										$("#msg").html("<p>"+res.message+"</p>"+history);
										var x1 = $("#selectedpokemon").children(".card-content").children("p");
										var x2 = $("#opponentpokemon").children(".card-content").children("p");
										var sel_x1 = $("#"+$(x1[3]).text()).children(".card-content").children("p")[2];
										var sel_x2 = $("#"+$(x2[3]).text()).children(".card-content").children("p")[2];
										$(x1[2]).text("HP : "+res.UserCurrHP+"/"+res.UserHp);
										$(x2[2]).text("HP : "+res.WildCurrHP+"/"+res.WildHp);
										$(sel_x1).text("HP : "+res.UserCurrHP+"/"+res.UserHp);
										$(sel_x2).text("HP : "+res.WildCurrHP+"/"+res.WildHp);
										$(a_info[1]).text("PP : "+res.PP);										
										if(res.PP == 0){					
											$(attackClick).off("click");
										}
										if(res.UserCurrHP==0 && res.WildCurrHP==0){
											alert("Both pokemons fainted");
											$("#pokemoves").css("display","none");
											$("#selectedpokemon").css("visibility","hidden");
											$("#"+$(x1[3]).text()).off("click");
											var nextid = "gymPokemons_"+(parseInt($(x2[3]).text().split("_")[1])+1);
											var exists = $("#"+nextid);
											if(exists.length!=0){
												var x = $("#"+nextid).children(".card-content").children();
												var poketeamno = nextid;
												$("#opponentpokemon").children(".card-image").children("img").attr("src","./Pokemons/front/"+$(x[4]).text()+".png");
												var pokeInfo = $("#opponentpokemon").children(".card-content").children();
												$(pokeInfo[0]).children("strong").text($(x[0]).children("strong").text());
												$(pokeInfo[1]).text($(x[1]).text());
												$(pokeInfo[2]).text($(x[2]).text());
												$(pokeInfo[3]).text($(x[3]).text());
												$(pokeInfo[4]).text(poketeamno);
												$("#opponentpokemon").css("visibility","visible");
											}
											else{
												alert("You have won(Draw)");
												$("#opponentpokemon").css("visibility","hidden");
											}
										}
										else if(res.UserCurrHP==0){
											alert("Your pokemon is unable to battle, Choose another or run away");
											$("#pokemoves").html("");
											$("#selectedpokemon").css("visibility","hidden");
											$("#"+$(x1[3]).text()).off("click");
										}
										else if(res.WildCurrHP==0){
											alert("Gym leader's pokemon is unable to battle");
											var nextid = "gymPokemons_"+(parseInt($(x2[3]).text().split("_")[1])+1);
											var exists = $("#"+nextid);
											if(exists.length!=0){
												var x = $("#"+nextid).children(".card-content").children();
												var poketeamno = nextid;
												$("#opponentpokemon").children(".card-image").children("img").attr("src","./Pokemons/front/"+$(x[4]).text()+".png");
												var pokeInfo = $("#opponentpokemon").children(".card-content").children();
												$(pokeInfo[0]).children("strong").text($(x[0]).children("strong").text());
												$(pokeInfo[1]).text($(x[1]).text());
												$(pokeInfo[2]).text($(x[2]).text());
												$(pokeInfo[3]).text($(x[3]).text());
												$(pokeInfo[4]).text(poketeamno);
												$("#opponentpokemon").css("visibility","visible");
											}
											else{
												alert("You have won");												
												$("#opponentpokemon").css("visibility","hidden");
												$("#pokemoves").html("");
											}
										}
									}									
								});
							});
						}
					});
					$("#selectedpokemon").css("visibility","visible");
				});
			}
		}
		if(rowid=="gymPokemons"){
			var x = $("#gymPokemons_1").children(".card-content").children();
			var poketeamno = "gymPokemons_1";
			$("#opponentpokemon").children(".card-image").children("img").attr("src","./Pokemons/front/"+$(x[4]).text()+".png");
			var pokeInfo = $("#opponentpokemon").children(".card-content").children();
			$(pokeInfo[0]).children("strong").text($(x[0]).children("strong").text());
			$(pokeInfo[1]).text($(x[1]).text());
			$(pokeInfo[2]).text($(x[2]).text());
			$(pokeInfo[3]).text($(x[3]).text());
			$(pokeInfo[4]).text(poketeamno);
			$("#opponentpokemon").css("visibility","visible");
		}
	}
	
	$(document).ready(function(){
		$("#modal1").modal({complete:function(){
			$("#playerTeam").html("");
			$("#gymPokemons").html("");
			$("#pokemoves").html("");
			$("#msg").html("");
			$("#selectedpokemon").css("visibility","hidden");
			$("#opponentpokemon").css("visibility","hidden");
		}});
		$("#navbar").load("navbar1.html",function(){
			$("#battleGymLeaders").addClass("active");
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$.post("BattleGymLeaders",{"function":"Get gym info"},function(data){
				var res = JSON.parse(data);
				fillTeam(res);				
				$("#navbar").css({opacity:"1"});
				$("#profile_content").animate({opacity:"1"},1000);
			});
			
		});
		$(".battle").click(function(event){
			event.preventDefault();
			select_apid = $(this).parent("div").parent("div").attr("id");
			$.post("Battle",{"type":"gym","state":"Battle begin","apid":select_apid},function(data){
				var res = JSON.parse(data);
				fillPlayerTeam(res.player,"playerTeam");
				fillPlayerTeam(res.gymLeader,"gymPokemons");
			});
			$("#modal1").modal("open");
		});
						
	});
</script>
</html>