<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
<title>Typing Tutor</title>
<link rel="stylesheet" href="css/modal.css" /> 
<link rel="stylesheet" href="css/index.css" />
<script type="text/javascript" src="js/jquery.js"></script>


</head>
<body>

<header>

            <div id="name">
                <div style="font-size: 23px; font-weight: bold; font-family: playfair display; color: white; letter-spacing: 2px; ">
                    TypeFast
                </div>
                <div style="font-size: 15px; font-family: cursive; ">
                </div>
            </div>
            <div id="navigation">
                <ul>
                    <li><a id="signinBtn">Sign in</a></li>
                    <li><a style="padding: 5px; border: 1px solid white; border-radius: 2px;" id="signupBtn">Sign up</a></li>
                </ul>
            </div>
            <div class="clear"></div>
        </header>
	
            <div id="left-navigation">
                <ul>
                    <a href="#"><li>Home</li></a>
                    <li><a href="#">Paragraph Test</a></li>
                    <li><a href="#">Random Word Test</a></li>
                    <li><a href="#">Competition</a></li>
                    <li><a id="addquotelink" >Add Quote</a></li>
                </ul>
            </div>
            
           <div id="panel">
                <div id="middle">

                    <div class="textarea">
                    <p id="container"></p>
                       
                    </div>

                    <div id="textinput">
                        <input type="text" id="field" placeholder="Type Here" />
                        <input type="button" id="refresh" onclick="refresh()" value="Refresh"/>
                    </div>

                    <p style="margin-top: 40px;">
                        Previous Test Results: (If your are not logged in ... Refreshing the page will lost the previous results)
                    </p>
                    <table id="temp_result" >
                    	<thead>
                    		<tr>
                    			<td>Speed</td>
                    			<td>Time</td>
                    			<td>Accuracy</td>
                    		</tr>
                    	</thead>
                    	<tbody id="result_list">
                    	</tbody>

                    </table>
                </div>
            </div> 

		<div id="result">

                <p id="test_result">Test Result</p>
                <table id="result_table">

                        <tr>
                            <td>Typing Speed:</td>
                            <td id="typingSpeed" style="font-weight:bold;">0.00 wpm</td>
                        </tr>
                        <tr>
                            <td>Time Taken:</td>
                            <td id="timeTaken" style="font-weight:bold;">00.00</td>
                        </tr>
                        <tr>
                            <td>Accuracy:</td>
                            <td id="accuracy" style="font-weight:bold;">00.00 %</td>
                        </tr>
                        <tr>
                            <td>Total Keys Pressed:</td>
                            <td id="keysPressed" style="font-weight:bold;"> -- </td>
                        </tr>
                        <tr>
                            <td>Correct Words:</td>
                            <td id="correctWords" style="font-weight:bold;"> -- </td>
                        </tr>
                        <tr>
                            <td>Wrong Words:</td>
                            <td id="wrongWords" style="font-weight:bold;"> -- </td>
                        </tr>
                </table>
            </div>





	
	
	<!-- Start Modal For Sign-up Form -->
	<div class="overlay" id="signupoverlay">
          <div class="modal" id="signupmodal">
            <!-- close trigger -->
            <div id="title">
                <span>Login</span>
                <span style="float:right; margin-right: 15px;" class="upclose">&times;</span>
            </div>

            <!-- modal content -->
            <div class="modal-content" style="text-align:center;">
			
            <p>FirstName:<input type="text" name="firstname" id="firstname" /></p>
            <p>LastName:<input type="text" name="lastname" id="lastname" /></p>
            <p>Username:<input type="text" name="username" id="username" /></p>
            <p>Email:<input type="email" name="email" id="email" /></p>
            <p>Password:<input type="password" name="password" id="password" /></p>
            <button id="register">Submit</button>

            <p style="text-align:right; margin-right: 180px;">
                <a href="#">Forgot Password ?</a><input type="button" name="submit" id="submit" value="Login"/>
            </p>

            </div>
          </div>
        </div>
	<!-- End Modal For Sign-up Form -->
	
	
	<!-- Start Modal For Sign-up Form -->
	<div class="overlay" id="signinoverlay">
          <div class="modal" id="signinmodal">
            <!-- close trigger -->
            <div id="title">
                <span>Login</span>
                <span style="float:right; margin-right: 15px;" class="inclose">&times;</span>
            </div>

            <!-- modal content -->
            <div class="modal-content" style="text-align:center;">
			
			<p><input type="checkbox" name="admin" id="admin" /> Administrator</p>
            <p>Email/Username<input type="text" name="loginuser" id="loginuser" /></p>
            <p>Password:<input type="password" name="loginpass" id="loginpass" /></p>

            <p style="text-align:right; margin-right: 180px;">
                <a href="#">Forgot Password ?</a><input type="button" name="login" id="login" value="Login"/>
            </p>

            </div>
          </div>
        </div>
	<!-- End Modal For Sign-up Form -->
	
	<p id="sessi"></p>
	

<script type="text/javascript" src="js/modal.js"></script>

<script>


var maintext;
var startTime;
var endTime;
var accuracy;
var keysPressed = 0;
var number = 0;
var currentWordIndex = 0;
var typedarr = [];
var array = [];
var serial = 1;
var name = '<%= session.getAttribute("username") %>';

$(document).ready(function(e){

	// get text in the div container
     $.ajax({
         type:'post',
         url:'Typing',
         contentType:'text/plain',
         success:function(result){
        	 
        	

        	 maintext = result;
             maintext = maintext.trim();
             var arr2 = maintext.split(" ");
             
             var text = "";
             for( var i = 0 ; i < arr2.length ; i++ ){
                 if( i === 0 ){
                     text += "<span style='color:red;'>"+arr2[i]+"</span> ";
                 }else{
                     text += arr2[i] + " ";
                 }
             }

             text = text.trim();
             $("#container").html(text);
             
         },
         error: function(){
             alert("Error retrieving data...");
         }
     })
	
     
     
     
     
     
     $("#field").on('keypress',function(e){
    	 

    	 
         keysPressed++;

         // if($("#field").val().trim() === "" ){
         //     $("#field").val("");
         //     return;
         // }
         if(number === 0 ){
             startTime = new Date().getTime();
         }


     // Space-Bar Pressed
         if (e.keyCode === 32) {
             currentWordIndex++;
             //alert("currentWordIndex " + currentWordIndex + " number is: " + number);
             typedarr[number] = $("#field").val(); // getting value from field and storing
             $("#field").val(""); // clearing the field after pressing space-bar

             $("#container").html("");

                 var text2 = maintext;
                 text2 = text2.trim();
                 var arr = text2.split(" ");
                 array = arr;

                 var text2 = "";
                 for( var i = 0 ; i < arr.length ; i++ ){
                     if( i === currentWordIndex ){
                         text2 += "<span style='color:red;'>"+arr[i]+"</span> ";
                     }else{
                         text2 += arr[i] + " ";
                     }
                 }

                 text2 = text2.trim();
                 $("#container").html(text2);

				// result calculations
                 if(number === array.length - 1){

                     endTime = new Date().getTime();

                     var min, sec;
                     // calculating WPM
                     var timeTaken = (endTime - startTime)/1000;
                     if(timeTaken > 60){
                         min = (timeTaken/60).toFixed(0);
                         sec = (timeTaken%60).toFixed(0);
                         timeTaken = min + " min " + sec + " sec ";
                     }else{
                    	 sec = timeTaken.toFixed(0);
                    	 timeTaken = sec + " sec";
                     }


                     var rightwords = 0;
                     var wrongwords = 0;


                     var result = "";
                     for(var i = 0 ; i < array.length ; i++ ){
                       	 result += typedarr[i] + " ";
                         if(array[i].trim() === typedarr[i].trim()){
                             rightwords++;
                         }else{
                             wrongwords++;
                         }
                      }
                     
                     alert(array.length);
                     alert(timeTaken);
                     
                     var speed = ((array.length/timeTaken ) * 60 ).toFixed(2);
						alert("Array length is: " + array.length);
                      if(rightwords == 0){
                          accuracy = 0;
                      }else{
                          accuracy = (rightwords/array.length)*100;
                          accuracy = accuracy.toFixed(2);
                      }
                      
                      var table = "<tr>"
		                          +"<td>"+ serial +"</td>"
		                          +"<td>"+ speed +"</td>"
		                          +"<td>"+ accuracy +"</td>"
		                          +"</tr>"
                      
                     $("#container").html("Click Refresh to Get the Text");
		             $('#typingSpeed').html(speed);
		             $('#timeTaken').html(timeTaken);
		             $('#accuracy').html(accuracy + " %");
		             $('#correctWords').html(rightwords);
		             $('#wrongWords').html(wrongwords);
                     alert("right words are: " + rightwords + " & wrong words are: " + wrongwords + " & keysPressed " + keysPressed +
                 " & accuracy is: " + accuracy + " %; speed is: " + speed + " wpm");
                     
                 }
				
             number++;
         }

     });
     
     
     $("#refresh").click(function(e){
    	 
    	 $.ajax({
             type:'post',
             url:'Typing',
             contentType:'text/plain',
             success:function(result){

            	 maintext = result;
                 maintext = maintext.trim();
                 var arr2 = maintext.split(" ");
                 
                 var text = "";
                 for( var i = 0 ; i < arr2.length ; i++ ){
                     if( i === 0 ){
                         text += "<span style='color:red;'>"+arr2[i]+"</span> ";
                     }else{
                         text += arr2[i] + " ";
                     }
                 }

                 text = text.trim();
                 $("#container").html(text);
                 
             },
             error: function(){
                 alert("Error retrieving data...");
             }
         })
    	 
    	 
    	  keysPressed = 0;
    	  number = 0;
    	  currentWordIndex = 0;
    	 
     });
     
     
     $("#register").click(function(e){
    	 
    	 var fname = $("#firstname").val();
    	 var lname = $("#lastname").val();
    	 var username = $("#username").val();
    	 var email = $("#email").val();
    	 var password = $("#password").val();
    	 
    	 var object = new Object();
    	 object.firstname = fname;
    	 object.lastname = lname;
    	 object.username = username;
    	 object.email = email;
    	 object.password = password;
    	 object.isadmin = false;
    	 
    	 var data = JSON.stringify(object);
    	 alert("Sending data");
    	 $.ajax({
    		type:'post',
    		url:'SignupServlet',
    		data:data,
    		contentType:'json',
    		dataType:'json',
    		success:function(result){
    			if(result){
    				alert("Registration Successful");
    			}else{
    				alert("Username may exists already. Try again");
    			}
    		}
    	 })
    	 
     });
     
     
$("#login").click(function(e){
    	 
    	
    	 var username = $("#loginuser").val();
    	 var password = $("#loginpass").val();
    	 var isadmin = $("#admin").is(":checked");
    	 alert("admin : " + isadmin);
    	 
    	 var object = new Object();
    	 
    	 object.username = username;
    	 object.password = password;
    	 object.isadmin = isadmin;
    	 
    	 var data = JSON.stringify(object);
    	 alert("Sending data");
    	 $.ajax({
    		type:'post',
    		url:'LoginServlet',
    		data:data,
    		contentType:'json',
    		dataType:'json',
    		success:function(result){
    			if(result == null){
    				alert("Error: Please try again.");
    				
    			}
    			alert("Login Successful; username is: " + result.username );
    			var name = '<%= session.getAttribute("username") %>';
				$("#sess").html(name);
    			
    		}
    	 })
    	 
     });
     
     
     
$("#logout").click(function(e){
	
	 alert("Logout clicked");
	 
	 $.ajax({
		type:'post',
		url:'LogoutServlet',
		success:function(result){
			window.location.replace("addquote.jsp");
		},
		error:function(){
			alert("Something went wrong");
		}
	 })
	 
});
     
     
     
     
     $("#username").on('keyup',function(){
    	 
    	 var username = $("#username").val();
    	 var object = new Object();
    	 object.username = username;
    	 var data = JSON.stringify(object);
    	 $.ajax({
     		type:'post',
     		url:'CheckUserServlet',
     		data:data,
     		contentType:'json',
     		dataType:'json',
     		success:function(result){
     			if(result){
     				$("#username").css('border',"2px solid red");
     			}else{
     				$("#username").css('border',"2px solid green");
     			}
     			
     		}
     	 })
    	 
     });
     
     $("#username").blur(function (event) {
 	   $(this).css('border','1px solid gray');
 	 })
     
 	 $("#addquotelink").click(function(event){
 		
 		if(name === null){
 			$("#sessi").html("You have to be member");
 		}else{
 			window.location.href = "addquote.jsp" ;
 		}
 	 });
     
     
     
});









</script>







</body>
</html>