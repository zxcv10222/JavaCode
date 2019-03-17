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
	<!--SumemerNote  -->
	  <link href="./resources/summernote/summernote-lite.css" rel="stylesheet">
	  <script src="./resources/summernote/summernote-lite.js"></script>
	  




<script>
$(document).ready(function() {

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

			<form action="write" method="post" id="writeForm" enctype="multipart/form-data" >
	<table>
	
		<tr>
			<th>category 
			<td><input type="text" id="category" name="category"  value="${board.category}">	
		</tr>
		<tr>
			<th>태그
			<td><input type="text" id="tag" name="tag"  value="${board.tag}">		
		</tr>

		<tr>
			<th>제목 
			<td><input type="text" id="title" name="title" value="${board.title}" >			
		</tr>
		<tr>
			<th>첨부파일 
			<td><input type="file" name="upload" size="30">			
		</tr>
		<tr>
			<th>내용
			<td><textarea id="content" name="content" value="">${board.content}</textarea>
			</td>	
		</tr>
							
			</table>
			<p align="center"><input type="submit" value="저장">
			<input type="button" value="뒤로가기" onclick="location.href = './list'">
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