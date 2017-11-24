<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="./materialize/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="./javascript/jquery-3.2.1.min.js"></script>
  <script src="./materialize/js/materialize.min.js"></script>
<title>Pokeshop</title>
</head>
<body>
<p style="display:none;" id="userName" >${name}</p>
<div id="navbar" style="opacity:0;" ></div>
<div class="container" style="opacity:0;" >
<div class="row">
<div class="col s1"></div>
	<div class="col s2">
	<h5 class="indigo-text center">Pokeball</h5><br>
	<p class="center"><a class="add center btn-floating btn waves-effect waves-light green">+</a></p>
	<p class="center item" id="1">0</p>
	<p class="center"><a class="sub center btn-floating btn waves-effect waves-light red">-</a></p>
	</div>
	<div class="col s2">
	<h5 class="indigo-text center">Megaball</h5><br>
	<p class="center"><a class="add center btn-floating btn waves-effect waves-light green">+</a></p>
	<p class="center item" id="2">0</p>
	<p class="center"><a class="sub center btn-floating btn waves-effect waves-light red">-</a></p>
	</div>
	<div class="col s2">
	<h5 class="indigo-text center">S Portion</h5><br>
	<p class="center"><a class="add center btn-floating btn waves-effect waves-light green">+</a></p>
	<p class="center item" id="3">0</p>
	<p class="center"><a class="sub center btn-floating btn waves-effect waves-light red">-</a></p>
	</div>
	<div class="col s2">
	<h5 class="indigo-text center">M Portion</h5><br>
	<p class="center"><a class="add center btn-floating btn waves-effect waves-light green">+</a></p>
	<p class="center item" id="4">0</p>
	<p class="center"><a class="sub center btn-floating btn waves-effect waves-light red">-</a></p>
	</div>
	<div class="col s2">
	<h5 class="indigo-text center">L Portion</h5><br>
	<p class="center"><a class="add center btn-floating btn waves-effect waves-light green">+</a></p>
	<p class="center item" id="5">0</p>
	<p class="center"><a class="sub center btn-floating btn waves-effect waves-light red">-</a></p>
	</div>	
</div>
<br>
<p class="center"><a id="sub" class="indigo waves-effect waves-light btn">Buy Items</a></p>
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$("#pokeshop").addClass("active");
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$("#navbar").css({opacity:"1"});
			$(".container").animate({opacity:"1"},1000);
		});
		$(".add").click(function(){
			var x = $(this).parent().siblings(".item");
			var n = parseInt($(x[0]).text())+1;
			$(x).text(n);
		});
		$(".sub").click(function(){
			var x = $(this).parent().siblings(".item");
			if(parseInt($(x).text())==0){
				alert("Negatives not allowed");
			}
			else{
				var n = parseInt($(x).text())-1;
				$(x).text(n);	
			}			
		});
		$("#sub").click(function(){
			$.post("Pokeshop",{"1":$("#1").text(),"2":$("#2").text(),"3":$("#3").text(),"4":$("#4").text(),"5":$("#5").text()},function(data){
				var res = JSON.parse(data);
				if(res.success){
					location.reload();
					alert(res.message);
				}
				else{
					alert(res.message);
				}
			});
		});
	});
</script>
</html>