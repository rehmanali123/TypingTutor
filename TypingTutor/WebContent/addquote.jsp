<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Quote</title>
<script type="text/javascript" src="js/jquery.js"></script>

</head>
<body>

<%	

	if((String) session.getAttribute("username") == null){
		out.print("<script>alert('You have to be a member to add quote');</script>");
		out.print("<script>window.location.replace('index.jsp');</script>");
	}
%>

<h3>Add Quote</h3>

<p>Note: Quote will be reviewed before adding.
<br/>Make is less than 600 characters. Can be edited if needed. May Take some time. </p>

Reference (book or website): <input type="text" name="book" id="book" /><br/>
Author: <input type="text" name="author" id="author" /><br/> 

Quote: <textarea rows="5" cols="80" id="quote"></textarea><br/>

<input type="button" name="addquote" value="Add Quote" id="addquote" />

<script>

$("#addquote").click(function(){
	
	var reference = $("#book").val();
	var author = $("#author").val();
	var quote = $("#quote").val();
	alert(quote);
	
	var object = {};
	object.quote = quote;
	object.reference = reference;
	object.author = author;
	object.status = "pending";
	
	var data = JSON.stringify(object);
	
	$.ajax({
 		type:'post',
 		url:'AddQuoteServlet',
 		data:data,
 		contentType:'json',
 		dataType:'json',
 		success:function(result){
 			if(result){
 				alert("added");
 			}else{
 				alert("something went wrong");
 			}
 			
 		}
 	 })
	
	
});


</script>




</body>
</html>