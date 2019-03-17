<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE html>
<html>
<head>
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
<meta charset="UTF-8">
<title>[게시판]</title>
</head>
<body>
	<c:if test="${errorMsg!=null}">
		<script>
			alert('${errorMsg}');
		</script>
	</c:if>
	<h1>[게시판]</h1>


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
			<td><input type="button" value="뒤로가기"
				onclick="location.href = '../'">
		</tr>
		<tr>
			<th>번호
			<th>제목
			<th>작성자
			<th>조회수
			<th>등록일
			<th>첨부파일
		</tr>

		<c:forEach var="board" items="${list }">
			<tr>
				<td>${board.boardnum }
				<td><a href="read?s_boardnum=${board.s_boardnum} ">
						${board.title }</a>
				<td>${board.id }
				<td>${board.hits }
				<td>${board.inputdate }
				<td align="center"><c:if test="${board.s_originalfile !=null}">
						<a href="download?boardnum=${ board.s_boardnum}"> <img
							src="../resources/img/save.png" height="20" width="20"></a>
					</c:if>
			</tr>
		</c:forEach>
	</table>
	<br>
	<br>

	<!-- 페이징 영역 -->
	<p align="center">

		<a href="javascript:formSubmit('${navi.currentPage -1}','${type}')">◀</a>
		<c:forEach var="n" begin="${ navi.startPageGroup}"
			end="${navi.endPageGroup}">
			<a href="javascript:formSubmit('${n}' , '${type}')">${n}</a>


		</c:forEach>
		<a href="javascript:formSubmit('${navi.currentPage +1}','${type}')">▶</a>

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
</body>
</html>