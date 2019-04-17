<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<%@ page session="true"%>

<html>
	<head>
	<!--Jquery  -->
	<script src="./resources/js/jquery-3.1.1.min.js"></script>
	
	<!--Jquery Ui -->
	<link href="./resources/js/jquery-ui.min.css" rel="stylesheet">
	<script src="./resources/js/jquery-ui.min.js"></script>
	
	<!--SumemerNote  -->
	  <link href="./resources/summernote/summernote-lite.css" rel="stylesheet">
	  <script src="./resources/summernote/summernote-lite.js"></script>
	  

  



<script>
$(document).ready(function() {
	$('#boardTypeSelect').on('change',selectChange);
	
	
});
	$(function(){
		
		$('#content').summernote({
			height: 600,
			fontNames : [ '맑은고딕', 'Arial', 'Arial Black', 'Comic Sans MS', 'Courier New', ],
			fontNamesIgnoreCheck : [ '맑은고딕' ],
			focus: true,
			disableDragAndDrop:true,
			callbacks: {
				onImageUpload: function(files, editor, welEditable) {
		            for (var i = files.length - 1; i >= 0; i--) {
		            	sendFile(files[i], this);
		            }
		        }
			}
			
		});
	})
	
	function sendFile(file, el) {
		var form_data = new FormData();
      	form_data.append('file', file);
      
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: './image',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(url) {
 
                $(el).summernote('editor.insertImage', url);
                
                
                $('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
              }
            });
          }
    
</script>


<script>


	function selectChange(){
		//alert($('#category').val());
		$('#boardType').val($('#boardTypeSelect').val());
		//alert($('#boardType').val());
	}

	
	

	function checkform(){
		
	
	  if( document.getElementById("boardType").value == "" )
	   {

	     alert( "boardType" );

	     return false;

	   }
	  if( document.getElementById("tag").value == "" )
	   {

	     alert( "tag " );

	     return false;

	   }
	  if( document.getElementById("title").value == "" )
	   {

	     alert( "title " );

	     return false;

	   }
	  if( document.getElementById("content").value == "" )
	   {

	     alert( "content " );

	     return false;

	   }		
		
		return true;
	}

		
	function retrieveImageFromClipboardAsBlob(pasteEvent, callback){
		if(pasteEvent.clipboardData == false){
	        if(typeof(callback) == "function"){
	            callback(undefined);
	        }
	    };

	    var items = pasteEvent.clipboardData.items;

	    if(items == undefined){
	        if(typeof(callback) == "function"){
	            callback(undefined);
	        }
	    };

	    for (var i = 0; i < items.length; i++) {
	        // Skip content if not image
	        if (items[i].type.indexOf("image") == -1) continue;
	        // Retrieve image on clipboard as blob
	        var blob = items[i].getAsFile();

	        if(typeof(callback) == "function"){
	            callback(blob);
	        }
	    }
	}

	window.addEventListener("paste", function(e){
		
	    // Handle the event
	    retrieveImageFromClipboardAsBlob(e, function(imageBlob){
	        // If there's an image, display it in the canvas
	        
	        if(imageBlob){
	        	sendFile2(imageBlob);
   
	        }
	    });
	}, false);


	function sendFile2(file) {
		var form_data = new FormData();
      	form_data.append('file', file);
      	
      	$.ajax({
        	data: form_data,
        	type: "POST",
        	url: './image',
        	cache: false,
        	contentType: false,
        	enctype: 'multipart/form-data',
        	processData: false,
        	success: function(url) {
         
        		$('#content').summernote('editor.insertImage', url);         
                $('#imageBoard > ul').append('<li><img src="'+url+'" width="480" height="auto"/></li>');
              }
            });
          }
	
	
	
</script>
	
		<title>No Sidebar - TXT by HTML5 UP</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
		<link rel="stylesheet" href="./resources/assets/css/main.css" />
	</head>
	<body class="is-preload">
		<div id="page-wrapper">

			<!-- Header -->
				<header id="header">
					<div class="logo container">
						<div>
							<h1><a href="index.html" id="logo">TXT</a></h1>
							<p>A responsive site template by HTML5 UP</p>
						</div>
					</div>
				</header>


			<!-- Nav -->
				<nav id="nav">
					<ul>
						<li><a href="./home">Home</a></li>
						<li>
							<a href="#">Dropdown</a>
							<ul>
								<li><a href="#">Lorem ipsum dolor</a></li>
								<li><a href="#">Magna phasellus</a></li>
								<li>
									<a href="#">Phasellus consequat</a>
									<ul>
										<li><a href="#">Lorem ipsum dolor</a></li>
										<li><a href="#">Phasellus consequat</a></li>
										<li><a href="#">Magna phasellus</a></li>
										<li><a href="#">Etiam dolore nisl</a></li>
									</ul>
								</li>
								<li><a href="#">Veroeros feugiat</a></li>
							</ul>
						</li>
						<li><a href="./left-sidebar">Left Sidebar</a></li>
						<li><a href="./right-sidebar">Right Sidebar</a></li>
						<li class="current"><a href="./no-sidebar">No Sidebar</a></li>
					</ul>
				</nav>

			<!-- Main -->
				<section id="main">
					<div class="container">
						<div class="row">
							<div class="col-12">
								<div class="content">

									<!-- Content -->
			
			<c:choose>

		    <c:when test="${edit eq 'edit'}">
		    	<form action="edit2" method="post" enctype="multipart/form-data" >
				<input type="hidden" id="edit" name="edit"  value="${edit}">
				<input type="hidden" id="boardnum" name="boardnum"  value="${board.boardnum}">
				
		    </c:when>
		 	
		    <c:otherwise>
		       <form action="write2" method="post" enctype="multipart/form-data" >
		    </c:otherwise>
		 
		</c:choose>
	<table>
	
		<tr>
			<input type="hidden" id="boardType" name="boardType"  value="${board.boardType}">
			<th>boardType 
			<td><select id="boardTypeSelect">
				 <option value="Notice">Notice</option>
				 <option value="info">info</option>
				 <option value="Questions">Questions</option>
			 </td></select>
			
			<c:if test="${edit eq 'edit'}">
				<script>
					$('#boardTypeSelect').val($('#boardType').val());
				</script>
			</c:if>	
		</tr>
		<tr>
			<th>name
			<td><input type="text" id="name" name="name"  value="${board.name}">		
		</tr>

		<tr>
			<th>title
			<td><input type="text" id="title" name="title" value="${board.title}" >			
		</tr>
		<tr>
			<th>file 
			<td><input type="file" name="upload" size="30">			
		</tr>
		<tr>
			<th>content
			<td><textarea id="content" name="content" value="">${bcontent}</textarea>
			</td>	
		</tr>
				
			</table>
			<p align="center"><input type="submit" value="save" onclick="return checkform();">
			<input type="button" value="back" onclick="location.href = './list2'">
</form>	
			
								</div>
							</div>
							

							</div>
						</div>
					</div>
				</section>
<!-- Footer -->
				<footer id="footer">
					<div class="container">
						<div class="row gtr-200">
							<div class="col-12">

								<!-- About -->
									<section>
										<h2 class="major"><span>What's this about?</span></h2>
										<p>
											This is <strong>TXT</strong>, yet another free responsive site template designed by
											<a href="http://twitter.com/ajlkn">AJ</a> for <a href="http://html5up.net">HTML5 UP</a>. It's released under the
											<a href="http://html5up.net/license/">Creative Commons Attribution</a> license so feel free to use it for
											whatever you're working on (personal or commercial), just be sure to give us credit for the design.
											That's basically it :)
										</p>
									</section>

							</div>
							<div class="col-12">

								<!-- Contact -->
									<section>
										<h2 class="major"><span>Get in touch</span></h2>
										<ul class="contact">
											<li><a class="icon fa-facebook" href="#"><span class="label">Facebook</span></a></li>
											<li><a class="icon fa-twitter" href="#"><span class="label">Twitter</span></a></li>
											<li><a class="icon fa-instagram" href="#"><span class="label">Instagram</span></a></li>
											<li><a class="icon fa-dribbble" href="#"><span class="label">Dribbble</span></a></li>
											<li><a class="icon fa-linkedin" href="#"><span class="label">LinkedIn</span></a></li>
										</ul>
									</section>

							</div>
						</div>

						<!-- Copyright -->
							<div id="copyright">
								<ul class="menu">
									<li>&copy; Untitled. All rights reserved</li><li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
								</ul>
							</div>

					</div>
				</footer>
			

		</div>

		

	</body>
</html>