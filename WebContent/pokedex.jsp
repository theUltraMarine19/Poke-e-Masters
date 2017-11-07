<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    import="org.json.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
 <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">
 <link rel="stylesheet" href="https://cdn.datatables.net/1.10.16/css/jquery.dataTables.min.css">
 <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script type="text/javascript" src="https://cdn.datatables.net/1.10.16/js/jquery.dataTables.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>
<title>Pokedex</title>
</head>
<body>
<p style="display:none;" id="userName" >${name}</p>
<div id="navbar"></div>
<div class="container" >
<div id="table_div" style="display:none;" >
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
</div>
</body>
<script type="text/javascript">
	$(document).ready(function(){
		$("#navbar").load("navbar1.html",function(){
			$(".dropdown-button").dropdown();
			$("#name_user").text($("#userName").text());
			$('#pokedex').addClass('active');			
			$('#table_div').css("display","block");
		});
		$('#myTable').DataTable({"lengthChange":false});
	});
</script>
</html>