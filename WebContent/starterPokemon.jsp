<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<title>Select your first pokemon</title>
</head>
<body>
<div class="container" >
<div class="row" >
<div class="col s6 offset-s3" >
<h4 class="indigo-text" >Choose your starter pokemon</h4>
</div>
</div>
<%
int[] s_id = (int[])request.getAttribute("pids");
for(int i=0;i<6;i++){
	out.println("<div class=\"row \"  ><div class=\"col s3\" ></div>");
	for(int j=0;j<3;j++){
		out.println("<div class=\"col s2\" ><div class=\"card-panel hoverable\" ><p class=\"center-align\" ><img id= \""+s_id[i*3+j]+"\" class=\"responsive-img\" src=\"./front/"+s_id[i*3+j]+".png\" ></p></div></div>");
	}
	out.println("</div>");
}
%>
</div>
</body>
<script type="text/javascript">
$(document).ready(function(){
	$(".card-panel").click(function(){
		var src = $(this).children("p").children("img").attr("id");
		$.post("Home",{"function":"starter_pokemon","src":src},function(data){
			var res = JSON.parse(data);
			if(res.success){
				window.location.replace("Home");
			}
			else{
				alert("Sorry, something went wrong try again");
			}
		});
	});
})
</script>
</html>