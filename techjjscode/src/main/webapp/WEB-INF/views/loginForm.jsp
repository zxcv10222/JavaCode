<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<%@ page session="true"%>



<html>
	<head>
	
	
	
	<title>Javascript Login Form Validation</title>
	<style>
			h2{
		background-color: #FEFFED;
		padding: 30px 35px;
		margin: -10px -50px;
		text-align:center;
		border-radius: 10px 10px 0 0;
		}
		hr{
		margin: 10px -50px;
		border: 0;
		border-top: 1px solid #ccc;
		margin-bottom: 40px;
		}
		div.container{
		width: 900px;
		height: 610px;
		margin:35px auto;
		font-family: 'Raleway', sans-serif;
		}
		div.main{
		width: 300px;
		padding: 10px 50px 25px;
		border: 2px solid gray;
		border-radius: 10px;
		font-family: raleway;
		float:left;
		margin-top:50px;
		}
		input[type=text],input[type=password]{
		width: 100%;
		height: 40px;
		padding: 5px;
		margin-bottom: 25px;
		margin-top: 5px;
		border: 2px solid #ccc;
		color: #4f4f4f;
		font-size: 16px;
		border-radius: 5px;
		}
		label{
		color: #464646;
		text-shadow: 0 1px 0 #fff;
		font-size: 14px;
		font-weight: bold;
		}
		center{
		font-size:32px;
		}
		.note{
		color:red;
		}
		.valid{
		color:green;
		}
		.back{
		text-decoration: none;
		border: 1px solid rgb(0, 143, 255);
		background-color: rgb(0, 214, 255);
		padding: 3px 20px;
		border-radius: 2px;
		color: black;
		}
		input[type=submit]{
		font-size: 16px;
		background: linear-gradient(#ffbc00 5%, #ffdd7f 100%);
		border: 1px solid #e5a900;
		color: #4E4D4B;
		font-weight: bold;
		cursor: pointer;
		width: 100%;
		border-radius: 5px;
		padding: 10px 0;
		outline:none;
		}
		input[type=summit]:hover{
		background: linear-gradient(#ffdd7f 5%, #ffbc00 100%);
		}

	</style>
	<script>

	function checkform(){
		
	
	  if( document.getElementById("id").value == "" )
	   {

	     alert( "id 입력" );

	     return false;

	   }
	  if( document.getElementById("password").value == "" )
	   {

	     alert( "password 입력" );

	     return false;

	   }
	
		
		return true;
	}
	
	</script>
	

	</head>
		<body>
		<div class="container">
		<div class="main">
			<h2>LOGIN</h2>
			
			<form action="login" method="post" >
				<label>User Name :</label>
				<input type="text" name="id" id="id"/>
				<label>Password :</label>
				<input type="password" name="password" id="password"/>
				<input type="submit" value="Login" id="submit" onclick="return checkform();"/>

			</form>
		
		</div>
		</div>
		</body>

	
</html>