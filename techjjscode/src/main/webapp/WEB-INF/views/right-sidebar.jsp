<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<%@ page session="true"%>

<html>
	<head>
	
	<script src="./resources/ckeditor/ckeditor.js"></script>
	<script src="./resources/js/jquery-3.1.1.min.js"></script>
	<script>
	
	
	/*jquery */
	$(document).ready(function() {

		
		//버튼 누를시 이벤트
		
		$('#search').on('click', search);
		//날짜설정 함수
		init();
	});
	
	
	/* 홈페이지 처음 시작할때 날짜설정 함수 */
	function init() {
		//첫날
		var start_date = new Date();

		//날짜 포맷
		var f_start = dateToYYYYMMDD(start_date);

		//document.getElementById('insertdate').value = f_start;


	};
	
	function dateToYYYYMMDD(date) {
		function pad(num) {
			num = num + '';
			return num.length < 2 ? '0' + num : num;
		}
		return date.getFullYear() + '-' + pad(date.getMonth() + 1) + '-'
				+ pad(date.getDate());
	};
	</script>
	
	<!-- ajax를 이용하여 글읽기 관련 처리 -->
<script>
	
function funcA(boardnum){

	
	$.ajax({
		url : 'read',
		type : 'POST',
		//서버로 보내는 parameter
		data : {
			boardnum : boardnum
		},
		dataType : 'json',
		success : output,
		error : function(e) {
			alert("aa");
			alert(JSON.stringify(e));
		}
	});
	

}
function output(ob) {

	var str ='<H3>';
	


	$.each(ob,function(i, board) {
						
		str += board.title

					});
	str += '</H3>';
	$('#titleDiv').html(str);
	
}



	

	
	</script>
	<script>
	function search() {
		var type = document.getElementById('option').value;
		document.getElementById('type').value = type;

	}
	function formSubmit(p, type) {
		var form = document.getElementById('pagingForm');
		var page = document.getElementById('page');
		document.getElementById('type').value = type;
		page.value = p;
		form.submit();
	}
</script>
	
	
		<input type="hidden" name="loginId" value="${loginId }" id="loginId">
	<input type="hidden" name="boardnum" value="${board.boardnum }">
	
	
	
	
		<title>Right Sidebar - TXT by HTML5 UP</title>
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
						<li class="current"><a href="./right-sidebar">Right Sidebar</a></li>
						<li><a href="./no-sidebar">No Sidebar</a></li>
					</ul>
				</nav>

			<!-- Main -->
				<section id="main">
					<div class="container">
						<div class="row">
							<div class="col-9 col-12-medium">
								<div class="content">

									<!-- Content -->

										<article class="box page-content">

											<header>
												<h2>Right Sidebar</h2>
												<!-- 이하 게시판 글 목록 -->
	<table>
		<tr>
			<td colspan="2">전체 : ${navi.totalRecordsCount} 페이지 :
				${navi.currentPage } / ${navi.totalPageCount }
			<td>
				<%-- <c:if test="${loginId !=null}"> --%>
					<td><input type="button" value="글쓰기"
						onclick="location.href = 'write'">
				<%-- </c:if> --%>
	
		</tr>
		<tr>
			<th>번호
			<th>제목
			<th>등록일
			<th>첨부파일
		</tr>
<a href="javascript:funcA();void(0);">함수호출2</a>


		<c:forEach var="board" items="${list }">
			<tr>
				<td>${board.boardnum }
				
				<td><a href="javascript:funcA(${board.boardnum});void(0);" >	
				<%-- <td><a href="read?boardnum=${board.boardnum} "> --%>
						${board.title }</a>
				<td>${board.id }
				<td>${board.insertdate }
				<td align="center"><c:if test="${board.originalfile !=null}">
						<a href="download?boardnum=${ board.boardnum}"> </a>
					</c:if>
			</tr>
		</c:forEach>
	</table>
	<br>
	<br>

	<!-- 페이징 영역 -->
	<p align="center">
		<a href="javascript:formSubmit('${navi.currentPage -5}','${type}')">◁◁</a>
		<a href="javascript:formSubmit('${navi.currentPage -1}','${type}')">◀</a>
		<c:forEach var="n" begin="${ navi.startPageGroup}"
			end="${navi.endPageGroup}">
			<a href="javascript:formSubmit('${n}' , '${type}')">${n}</a>


		</c:forEach>
		<a href="javascript:formSubmit('${navi.currentPage +1}','${type}')">▶</a>
		<a href="javascript:formSubmit('${navi.currentPage +5}','${type}')">▷▷</a>

		<!-- 게시판 검색  폼영역 -->
	<form action="list" onsubmit="search()" method="get" id="pagingForm">
		<input type="hidden" name="type" id="type"> <input
			type="hidden" name="page" id="page" value="1"> <br>
		<p align="center">

			<select id="option">

				<c:choose>
					<c:when test="${type == 'title'}">
						<option value="title" selected="selected">제목</option>
						<option value="titleContent">제목+내용</option>
						<option value="id">작성자</option>
					</c:when>
					<c:when test="${type == 'titleContent'}">
						<option value="title">제목</option>
						<option value="titleContent" selected="selected">제목+내용</option>
						<option value="id">작성자</option>
					</c:when>
					<c:when test="${type == 'id'}">
						<option value="title">제목</option>
						<option value="titleContent">제목+내용</option>
						<option value="id" selected="selected">작성자</option>
					</c:when>
					<c:otherwise>
						<option value="title" selected="selected">제목</option>
						<option value="titleContent">제목+내용</option>
						<option value="id">작성자</option>
					</c:otherwise>
				</c:choose>

			</select> 

			
			<input type="text" name="searchText" value="${searchText}">
			<input type="submit" value="검색">
			
	</form>
												
			
												
												<div id="titleDiv" name="titleDiv"></div>
												<p>Semper amet scelerisque metus faucibus morbi congue mattis</p>
												<ul class="meta">
													<li class="icon fa-clock-o">5 days ago</li>
													<li class="icon fa-comments"><a href="#">1,024</a></li>
												</ul>
											</header>

											<section>
												
												<p>
													Phasellus quam turpis, feugiat sit amet ornare in, hendrerit in lectus.
													Praesent semper mod quis eget mi. Etiam eu ante risus. Aliquam erat volutpat.
													Aliquam luctus et mattis lectus sit amet pulvinar. Nam turpis nisi
													consequat etiam lorem ipsum dolor sit amet nullam.
												</p>
											</section>

											<section>
												<h3>More intriguing information</h3>
												<p>
													Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac quam risus, at tempus
													justo. Sed dictum rutrum massa eu volutpat. Quisque vitae hendrerit sem. Pellentesque lorem felis,
													ultricies a bibendum id, bibendum sit amet nisl. Mauris et lorem quam. Maecenas rutrum imperdiet
													vulputate. Nulla quis nibh ipsum, sed egestas justo. Morbi ut ante mattis orci convallis tempor.
													Etiam a lacus a lacus pharetra porttitor quis accumsan odio. Sed vel euismod nisi. Etiam convallis
													rhoncus dui quis euismod. Maecenas lorem tellus, congue et condimentum ac, ullamcorper non sapien
													vulputate. Nulla quis nibh ipsum, sed egestas justo. Morbi ut ante mattis orci convallis tempor.
													Etiam a lacus a lacus pharetra porttitor quis accumsan odio. Sed vel euismod nisi. Etiam convallis
													rhoncus dui quis euismod. Maecenas lorem tellus, congue et condimentum ac, ullamcorper non sapien.
													Donec sagittis massa et leo semper a scelerisque metus faucibus. Morbi congue mattis mi.
													Phasellus sed nisl vitae risus tristique volutpat. Cras rutrum commodo luctus.
												</p>
												<p>
													Phasellus odio risus, faucibus et viverra vitae, eleifend ac purus. Praesent mattis, enim
													quis hendrerit porttitor, sapien tortor viverra magna, sit amet rhoncus nisl lacus nec arcu.
													Suspendisse laoreet metus ut metus imperdiet interdum aliquam justo tincidunt. Mauris dolor urna,
													fringilla vel malesuada ac, dignissim eu mi. Praesent mollis massa ac nulla pretium pretium.
													Etiam a lacus a lacus pharetra porttitor quis accumsan odio. Sed vel euismod nisi. Etiam convallis
													rhoncus dui quis euismod. Maecenas lorem tellus, congue et condimentum ac, ullamcorper non sapien.
													Donec sagittis massa et leo semper a scelerisque metus faucibus. Morbi congue mattis mi.
													Maecenas tortor mauris, consectetur pellentesque dapibus eget, tincidunt vitae arcu.
													Vestibulum purus augue, tincidunt sit amet iaculis id, porta eu purus.
												</p>
											</section>

											<section>
												<h3>So in conclusion ...</h3>
												<p>
													Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ac quam risus, at tempus
													justo. Sed dictum rutrum massa eu volutpat. Quisque vitae hendrerit sem. Pellentesque lorem felis,
													ultricies a bibendum id, bibendum sit amet nisl. Mauris et lorem quam. Maecenas rutrum imperdiet
													vulputate. Nulla quis nibh ipsum, sed egestas justo. Morbi ut ante mattis orci convallis tempor.
													Etiam a lacus a lacus pharetra porttitor quis accumsan odio. Sed vel euismod nisi. Etiam convallis
													rhoncus dui quis euismod. Maecenas lorem tellus, congue et condimentum ac, ullamcorper non sapien.
													Donec sagittis massa et leo semper a scelerisque metus faucibus. Morbi congue mattis mi.
													Phasellus sed nisl vitae.
												</p>
												<p>
													Suspendisse laoreet metus ut metus imperdiet interdum aliquam justo tincidunt. Mauris dolor urna,
													fringilla vel malesuada ac, dignissim eu mi. Praesent mollis massa ac nulla pretium pretium.
													Maecenas tortor mauris, consectetur pellentesque dapibus eget, tincidunt vitae arcu.
													Vestibulum purus augue, tincidunt sit amet iaculis id, porta eu purus.
												</p>
											</section>

										</article>

								</div>
							</div>
							<div class="col-3 col-12-medium">
								<div class="sidebar">

									<!-- Sidebar -->

										<!-- Recent Posts -->
											<section>
												<h2 class="major"><span>공부<span></h2>
												<ul class="divided">
													<li>
														<article class="box post-summary">
															<h3><a href="#" name="category" value ="network" >네트워크</a></h3>
														</article>
													</li>
													<li>
														<article class="box post-summary">
															<h3><a href="#" name="category" value ="server">서버</a></h3>
															
														</article>
													</li>
													<li>
														<article class="box post-summary">
															<h3><a href="#" name="category" value ="development">개발</a></h3>
															
														</article>
													</li>
													
													<li>
														<article class="box post-summary">
															<h3><a href="#" name="category" value ="security">세큐리티</a></h3>
														</article>
													</li>
													<li>
														<article class="box post-summary">
															<h3><a href="#" name="category" value ="news">신문</a></h3>
														</article>
													</li>
												</ul>
												<a href="#" class="button alt">Arcives</a>
											</section>

										<!-- Something -->
											<section>
												<h2 class="major"><span>Ipsum Dolore</span></h2>
												<a href="#" class="image featured"><img src="./resources/images/pic03.jpg" alt="" /></a>
												<p>
													Donec sagittis massa et leo semper scele risque metus faucibus. Morbi congue mattis mi.
													Phasellus sed nisl vitae risus tristique volutpat. Cras rutrum sed commodo luctus blandit.
												</p>
												<a href="#" class="button alt">Learn more</a>
											</section>

										<!-- Something -->
											<section>
												<h2 class="major"><span>Magna Feugiat</span></h2>
												<p>
													Rhoncus dui quis euismod. Maecenas lorem tellus, congue et condimentum ac, ullamcorper non sapien.
													Donec sagittis massa et leo semper scele risque metus faucibus. Morbi congue mattis mi.
													Phasellus sed nisl vitae risus tristique volutpat. Cras rutrum sed commodo luctus blandit.
												</p>
												<a href="#" class="button alt">Learn more</a>
											</section>

								</div>
							</div>
							<div class="col-12">

								<!-- Features -->
									<section class="box features">
										<h2 class="major"><span>A Major Heading</span></h2>
										<div>
											<div class="row">
												<div class="col-3 col-6-medium col-12-small">

													<!-- Feature -->
														<section class="box feature">
															<a href="#" class="image featured"><img src="./resources/images/pic01.jpg" alt="" /></a>
															<h3><a href="#">A Subheading</a></h3>
															<p>
																Phasellus quam turpis, feugiat sit amet ornare in, a hendrerit in
																lectus dolore. Praesent semper mod quis eget sed etiam eu ante risus.
															</p>
														</section>

												</div>
												<div class="col-3 col-6-medium col-12-small">

													<!-- Feature -->
														<section class="box feature">
															<a href="#" class="image featured"><img src="./resources/images/pic02.jpg" alt="" /></a>
															<h3><a href="#">Another Subheading</a></h3>
															<p>
																Phasellus quam turpis, feugiat sit amet ornare in, a hendrerit in
																lectus dolore. Praesent semper mod quis eget sed etiam eu ante risus.
															</p>
														</section>

												</div>
												<div class="col-3 col-6-medium col-12-small">

													<!-- Feature -->
														<section class="box feature">
															<a href="#" class="image featured"><img src="./resources/images/pic03.jpg" alt="" /></a>
															<h3><a href="#">And Another</a></h3>
															<p>
																Phasellus quam turpis, feugiat sit amet ornare in, a hendrerit in
																lectus dolore. Praesent semper mod quis eget sed etiam eu ante risus.
															</p>
														</section>

												</div>
												<div class="col-3 col-6-medium col-12-small">

													<!-- Feature -->
														<section class="box feature">
															<a href="#" class="image featured"><img src="./resources/images/pic04.jpg" alt="" /></a>
															<h3><a href="#">And One More</a></h3>
															<p>
																Phasellus quam turpis, feugiat sit amet ornare in, a hendrerit in
																lectus dolore. Praesent semper mod quis eget sed etiam eu ante risus.
															</p>
														</section>

												</div>
												<div class="col-12">
													<ul class="actions">
														<li><a href="#" class="button large">Do Something</a></li>
														<li><a href="#" class="button alt large">Think About It</a></li>
													</ul>
												</div>
											</div>
										</div>
									</section>

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

		<!-- Scripts -->
			<script src="./resources/assets/js/jquery.min.js"></script>
			<script src="./resources/assets/js/jquery.dropotron.min.js"></script>
			<script src="./resources/assets/js/jquery.scrolly.min.js"></script>
			<script src="./resources/assets/js/browser.min.js"></script>
			<script src="./resources/assets/js/breakpoints.min.js"></script>
			<script src="./resources/assets/js/util.js"></script>
			<script src="./resources/assets/js/main.js"></script>

	</body>
</html>