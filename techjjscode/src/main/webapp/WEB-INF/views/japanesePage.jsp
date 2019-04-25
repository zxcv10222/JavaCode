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
		if ('${type}' == 'title') {
			$("#option option:eq(0)").attr("selected", "selected");
		} else if ('${type}' == 'titleContent') {
			$("#option option:eq(1)").attr("selected", "selected");
		}

	});
</script>

<!-- ajax를 이용하여 글읽기 관련 처리 -->
<script>
	function boardRead(boardnum) {

		$.ajax({
			url : 'read2',
			type : 'POST',
			//서버로 보내는 parameter
			data : {
				boardnum : boardnum
			},
			dataType : 'json',
			success : output,
			error : function(e) {

				alert(JSON.stringify(e));
			}
		});

	}
	function output(ob) {

		var str = '<H2>';
		var str2 = '';
		var str3 = '<h4 style="text-align:right">'

		$.each(ob, function(i, board) {

			str += board.title
			str2 += board.content
			str3 += 'boardType : ' + board.boardType
			str3 += '</h4>'
			str3 += '<h4 style="text-align:right">'
			str3 += 'name : ' + board.name
			str3 += '</h4>'
		});
		str += '</H2>';

		$('#titleDiv').html(str);
		$('#ContentDiv').html(str2);
		$('#boardTypeDiv').html(str3);

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

	function delchk() {
		return confirm("삭제하시겠습니까?");
	}
</script>


<input type="hidden" name="boardnum" value="${board.boardnum }">





<title>Right Sidebar - TXT by HTML5 UP</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="./resources/assets/css/main.css" />


</head>



<body class="is-preload">
	<div id="page-wrapper">
		<!-- Main -->
		<section id="main">
			<div class="container">
				<div class="row">
					<div class="col-12 col-12-medium" style="border: 1px solid black;">
						<h2>검색 결과 테이블</h2>
						<table>
							<tr>
								<td><input type="button" value="글쓰기"
									onclick="location.href = 'write2'">
							</tr>
							<tr>
								<th>제목
								<th>
								<th>
								<th>
								<th>등록일
								<th>첨부파일
								<th>수정
								<th>삭제
							</tr>
							<c:forEach var="board2" items="${list2}">
								<tr>
									<td>${board2.boardnum}<a
										href="javascript:boardRead(${board2.boardnum});void(0);">
											${board2.title}</a>
									<td>
									<td>
									<td>
									<td>${board2.updatedate }
									<td align="center"><c:if
											test="${board2.originalfile !=null}">
											<a href="download?boardnum=${ board2.boardnum}">${board2.originalfile}</a>
										</c:if>
									<td><a href="./edit2?boardnum=${board2.boardnum}">수정</a>
									<td>${board2.boardType}<td><a href="./delete2?boardnum=${board2.boardnum}"
										onclick="return delchk();">삭제</a>
								
								</tr>
							</c:forEach>
						</table>
						<!-- 페이징 영역 -->
						<p align="center">

							<a
								href="javascript:formSubmit('${navi.currentPage -1}','${type}')">◀</a>
							<c:forEach var="n" begin="${ navi.startPageGroup}"
								end="${navi.endPageGroup}">
								<a href="javascript:formSubmit('${n}' , '${type}')">${n}
							</a></c:forEach>
									
							<a
								href="javascript:formSubmit('${navi.currentPage +1}','${type}')">▶</a>


							<!-- 게시판 검색  폼영역 -->
						
						<form action="list2" onsubmit="search()" method="get"
							id="pagingForm">
							<input type="hidden" name="type" id="type"> <input
								type="hidden" name="page" id="page" value="1"> <br>
							<p align="center">

								<select id="option">
									<option value="title" id="title">title</option>
									<option value="titleContent" id="titleContent">title+content</option>
								</select> <input type="text" id="searchText" name="searchText"
									value="${searchText}"> <input type="submit" value="검색">
						
						</form>



					</div>



				</div>
			</div>
			<div class="container">
				<div class="row">
					<div class="col-12 col-12-medium" style="border: 1px solid black;">


						<!-- 이하 게시판 글 목록 -->
						<div id="boardTypeDiv" name="boardTypeDiv"></div>
						<div id="titleDiv" name="titleDiv"></div>
						<div id="ContentDiv" name="ContentDiv"
							style="width: 160; height: 20; overflow-x: hidden; overflow-y: hidden"></div>

					</div>



				</div>
			</div>


			<!-- </div>  -->
		</section>

		<!-- Footer -->
		<footer id="footer">
			<div class="container">
				<div class="row gtr-200">
					<div class="col-12">

						<!-- About -->
						<section>
							<h2 class="major">
								<span>What's this about?</span>
							</h2>
							<p>
								This is <strong>TXT</strong>, yet another free responsive site
								template designed by <a href="http://twitter.com/ajlkn">AJ</a>
								for <a href="http://html5up.net">HTML5 UP</a>. It's released
								under the <a href="http://html5up.net/license/">Creative
									Commons Attribution</a> license so feel free to use it for whatever
								you're working on (personal or commercial), just be sure to give
								us credit for the design. That's basically it :)
							</p>
						</section>

					</div>
					<div class="col-12">

						<!-- Contact -->
						<section>
							<h2 class="major">
								<span>Get in touch</span>
							</h2>
							<ul class="contact">
								<li><a class="icon fa-facebook" href="#"><span
										class="label">Facebook</span></a></li>
								<li><a class="icon fa-twitter" href="#"><span
										class="label">Twitter</span></a></li>
								<li><a class="icon fa-instagram" href="#"><span
										class="label">Instagram</span></a></li>
								<li><a class="icon fa-dribbble" href="#"><span
										class="label">Dribbble</span></a></li>
								<li><a class="icon fa-linkedin" href="#"><span
										class="label">LinkedIn</span></a></li>
							</ul>
						</section>

					</div>
				</div>

				<!-- Copyright -->
				<div id="copyright">
					<ul class="menu">
						<li>&copy; Untitled. All rights reserved</li>
						<li>Design: <a href="http://html5up.net">HTML5 UP</a></li>
					</ul>
				</div>

			</div>
		</footer>

	</div>

</body>
</html>