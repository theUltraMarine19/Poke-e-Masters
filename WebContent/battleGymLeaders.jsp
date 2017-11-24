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
    out.println("<div class=\"col s2\"><div class=\"card\"><div id="+id+" style=\"visibility:hidden;\"><div class=\"card-image\"><img style=\"height:100px\" src=\"./GymLeaders/front/1.png\"></div><div class=\"card-content\"><h6 class=\"indigo-text\" ><strong>Bulbasaur</strong></h6><p>Santalune City</p><a class=\"battle btn btn-floating pulse\" href=\"#\" ><i class=\"material-icons\">arrow_forward</i></a></div></div></div></div>");
}
%>
</div>
<div class="divider"> </div>
  
</div>
</div>
</body>
<script type="text/javascript">
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
	
	$(document).ready(function(){
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
		$(".battle").click(function(){
			var select = $(this).parent("div").parent("div").attr("id");
			alert(select);

		});
						
	});
</script>
</html>