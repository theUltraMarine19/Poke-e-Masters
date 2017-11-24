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
  <script src="./materialize/js/materialize.min.js"></script>
    <script type="text/javascript" src="./DataTables/datatables.min.js"></script>
  <script src="//cdnjs.cloudflare.com/ajax/libs/html2canvas/0.4.1/html2canvas.min.js"></script>
  
<title>Create Map</title>
<style type="text/css">
#cont {
    position:relative;
    left: 0px;
    top: 0px;
    float: left;
    background-image: url('./Backgrounds/bkg1.jpg');
    width: 460px;
    height: 320px;
    
}
#img2 {
    position: absolute;
    left: 0px;
    top: 0px;
    width: 20px;
    height: 20px;
}

</style>
<script>
	$(document).ready(function(){
		var i;
		var CityNameVar;
		var BaseLevelVar;
		var currObs="";
		var NotAllowed = [];
		for(i=1;i<4;i++){
		$("#backgrounds").append("<div class=\"col s3\" >\n" + 
				"<div class=\"card-panel hoverable\" >\n" + 
				"	<p class=\"center-align\" >\n" + 
				"		<img id=\"bkg"+i+"\" class=\"responsive-img\" style=\"height:100px;width:150px;\" src=\"./Backgrounds/bkg"+i+".jpg\" >\n" + 
				"	</p>\n" + 
				"</div>\n" + 
				"</div>");
		}
		$(".card-panel").on('click',function(){
			var src = $(this).children("p").children("img").attr("id");
			if (src.indexOf("bkg") !== -1)	{
				$("#cont").css({"background-image":"url('./Backgrounds/"+src+".jpg')"});
			}
			else if (src.indexOf("obs") !== -1)	{
				var src1 = $(this).children("p").children("img").attr("id");
				currObs = src1;
			}
		});
		$("#CityForm").on('submit',function() { 
			var screenshot;
	        html2canvas($("#cont"), {
	            onrendered: function(canvas) {
	            	screenshot = canvas.toDataURL("image/png");
	            	CityNameVar = $('#CityForm').find('input[name="city_name"]').val();
	     	        BaseLevelVar = $('#CityForm').find('input[name="base_level"]').val();
	     	        $.ajax({
	           		  type: "POST",
	           		  url: "CreateMap",
	           		  data: { 
	           		     imgBase64: screenshot,
	           		     points: NotAllowed.toString(),
	           		     cityName: CityNameVar,
	           		     baseLevel: BaseLevelVar
	           		  }
	           		});
	            },
	            width: 920,
	            height: 920
	        });
	    });
		$("#cont").on('click',function(e){
			
			var divPos = $("#cont").position();
			var x = Math.floor(Math.floor(e.pageX - divPos.left)/20)*20;
			var y = Math.floor(Math.floor(e.pageY - divPos.top)/20)*20;
			if (currObs.indexOf("obs") !== -1)
			{
				if (e.ctrlKey)
				{
					$("#"+x+"-"+y).remove();
					var index = NotAllowed.indexOf(x+','+y);
					if (index > -1) {
					    NotAllowed.splice(index, 1);
					}
				}
				else
				{
					var index = NotAllowed.indexOf(x+","+y);
					if (index == -1) {   
					NotAllowed.push(x+","+y);
					$("#"+x+"-"+y).remove();
					$("#cont").append("<img src=\"./Obstacles/"+currObs+".png\" style=\"position:absolute; height:20px; width:20px; left:"+x+"px; top:"+y+"px;\" id=\""+x+"-"+y+"\">");
					
					}
				}
			}
			else
			{
				if (e.ctrlKey)
				{
					$("#"+x+"-"+y).remove();
					var index = NotAllowed.indexOf(x+","+y);
					if (index > -1) {
					    NotAllowed.splice(index, 1);
					}
				}
			}

		});
		
	});
</script>
</head>
<body>

<div class="container">
<div class="row" >
<div class="col s4 offset-s4" >
<h4 class="indigo-text" >Create your city</h4>
</div>
</div>
<form id="CityForm">
<div class ="row" >
<div class="input-field col s6">
<input id = "city_name" name="city_name" type = "text" class="validate" required>
<label for="city_name">City Name</label>
</div>
<div class="input-field col s6">
<input id = "base_level" name="base_level" class="validate" type = "text" required>
<label for="base_level">Base Level</label>
</div>
</div>


<div class="row" id="backgrounds">
</div>
<button type="submit" value="submit">Save Map</button> 
<div class="row" > 
<div class="col s8" >
<div id="cont">
	
</div>
</div>
<div class="col s2" >
<div class="row">
<div class="card-panel hoverable" >
	<p class="center-align" >
		<img id="obs1" class="responsive-img" style="height:100px;width:150px;" src="./Obstacles/obs1.png" >
	</p>
</div>
</div>
<div class="row">
<div class="card-panel hoverable" >
	<p class="center-align" >
		<img id="obs2" class="responsive-img" style="height:100px;width:150px;" src="./Obstacles/obs2.png" >
	</p>
</div>
</div>
</div>
<div class="col s2 " >
<div class="row">
<div class="card-panel hoverable" >
	<p class="center-align" >
		<img id="obs3" class="responsive-img" style="height:100px;width:150px;" src="./Obstacles/obs3.png" >
	</p>
</div>
</div>
<div class="row">
<div class="card-panel hoverable" >
	<p class="center-align" >
		<img id="obs4" class="responsive-img" style="height:100px;width:150px;" src="./Obstacles/obs4.png" >
	</p>
</div>
</div>
</div>
</div>


</form>
</div>
<p id="p1"></p>

</body>
</html>