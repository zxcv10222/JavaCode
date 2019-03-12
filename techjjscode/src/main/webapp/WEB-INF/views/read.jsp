<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<script>
	function check(boardnum) {
		if (confirm('정말로 삭제합니까??')) {
			location.href = 'delete?boardnum=' + boardnum;
		}

	}

	function replydelete(boardnum, replynum) {
		if (confirm('정말로 삭제합니까??')) {
			location.href = 'replyDelete?boardnum=' + boardnum + '&replynum='
					+ replynum;
		}
	}
	function replyedit(replynum) {
		var f = document.getElementById('replyeditForm');
		var text = prompt('수정할 내용을 입력하세요.');
		document.getElementById('replynum2').value = replynum;
		document.getElementById('text2').value = text;

		f.submit();
	}
</script>

<link rel="stylesheet" href="../resources/css/board.css">
<meta charset="UTF-8">
<title>[게시판 글읽기]</title>
<!-- ajax를 이용하여 리플 관련 처리 -->
<script src="../resources/js/jquery-3.1.1.min.js"></script>
<script>
	$(document).ready(function() {
		$('#replyWrtie').on('click', replyWrite);
		init();
	});
	function init() {
		//서버로 데이터 전송
		var boardnum = $('#boardnum').val();
		$.ajax({
			url : 'replyRead',
			type : 'GET',
			//서버로 보내는 parameter
			data : {
				boardnum : boardnum
			},
			dataType : 'json',
			success : output

			,
			error : function(e) {

				alert(JSON.stringify(e));
			}
		});

	}
	function output(ob) {

		var str = '<table> <tr> <th>ID<th>내용<th>수정<th>삭제</tr>';
		var loginId = $('#loginId').val();

		$
				.each(
						ob,
						function(i, reply) {
							if (loginId == reply.id) {
								str += '<tr><td class="tdId">' + reply.id
										+ '<td class="tdText">' + reply.text;
								str += '<td><input type="button" value="수정" class="replyEditBtn" >'
								str += '<td><input type="button" value="삭제" class="replyDeleteBtn" replynum="'+reply.replynum +'">'
							} else {
								str += '<tr><td class="tdId">' + reply.id
										+ '<td class="tdText">' + reply.text;
								str += '<td><td>'
							}

						});
		str += '</table>';
		$('#replyDiv').html(str);
		//새로운 객체를 생성하여 이벤트 처리
		$('.replyEditBtn').on('click', edit);
		$('.replyDeleteBtn').on('click', del);
	}
	function edit() {
		var boardnum = $('#boardnum').val();
		var replynum = $(this).attr('replynum');

	}
	function del() {
		var boardnum = $('#boardnum').val();
		var replynum = $(this).attr('replynum');

		var check = confirm('정말로 삭제 합니까?');

		if (check) {
			$.ajax({
				url : 'replyDelete2',
				type : 'POST',
				//서버로 보내는 parameter
				data : {
					replynum : replynum,
					boardnum : boardnum
				},
				dataType : 'json',
				success : output

				,
				error : function(e) {
					alert(JSON.stringify(e));
				}
			});

		}
	}
	function replyWrite() {
		$.ajax({
			url : 'replyWrite2',
			type : 'POST',
			//서버로 보내는 parameter
			data : $('#writeForm').serialize(),
			success : output

			,
			error : function(e) {

				alert(JSON.stringify(e));
			}
		});

	}
</script>
</head>
<body>
	<c:if test="${errorMsg!=null}">
		<script>
			alert('${errorMsg}');
		</script>
	</c:if>
	<input type="hidden" name="loginId" value="${loginId }" id="loginId">
	<input type="hidden" name="boardnum" value="${board.boardnum }"
		id="boardnum">
	<h1>[게시판 글읽기]</h1>

	<form action="">
		<table>
			<tr>
				<th>작성자
				<td>${board.id}
			</tr>
			<tr>
				<th>작성일
				<td>${board.inputdate}
			</tr>
			<tr>
				<th>조회수
				<td>${board.hits }
			</tr>
			<tr>
				<th>제목
				<td>${board.title }
			</tr>
			<tr>
				<th>내용
				<td>${board.content }</td>

			</tr>
			<tr>
				<th>파일첨부 <c:if test="${board.savedfile!=null }">
						<td><a href="download?boardnum=${ board.boardnum}">
								${board.originalfile } <img
								src="download?boardnum=${ board.boardnum}" height="20">
					</c:if>
			</tr>
		</table>
		<!-- 수정 삭제 목록 -->
		<p align="center">
			<c:if test="${board.id== loginId}">
				<!-- 현재글 삭제하기 -->
				<a href="javascript:check(${board.boardnum })">삭제</a>
				<!-- 현재글 수정하기 -->
				<a href="edit?boardnum=${board.boardnum }">수정</a>
			</c:if>
			<a href="list">목록보기</a>
	</form>
	<!-- 리플 -->
	<c:if test="${loginId !=null }">
		<form action="replyWrite" method="post" id="writeForm">
			<input type="hidden" name="boardnum" value="${board.boardnum }">
			<p align="center">
				리플내용 <input type="text" name="text" id="text" size="50">
				<!--기존 방식  -->
				<!-- <input type="submit" value="확인"> -->
				<!-- ajax이용하여 리플작성 -->
				<input type="button" id="replyWrtie" value="확인">
		</form>
	</c:if>
	<!-- 리플작성 폼 끝 -->
	<!-- 리플 수정을 위한 폼 -->
	<form action="replyEdit" method="post" id="replyeditForm">
		<input type="hidden" name="boardnum" value="${board.boardnum }">
		<input type="hidden" name="replynum" id="replynum2"> <input
			type="hidden" name="text" id="text2">

	</form>
	<table>
		<colgroup>
			<col width="30px">
			<col width="2000px">
			<col width="30px">
			<col width="30px">
		</colgroup>
		<!-- reply 새로고침시 새로 가져옴 model에 넣어옴  -->
		<%-- 			<c:forEach var="reply" items="${replylist }">
				<tr>
					<th>${reply.id}
					
					<td>${reply.text }
					<c:if test="${loginId ==reply.id}">
						<td align="center"> <a href="javascript:replyedit('${reply.replynum }')">수정</a>
						<td align="center"> <a href="javascript:replydelete('${board.boardnum }','${reply.replynum }')">삭제</a>
					</c:if>
						
			
			</c:forEach> --%>
		<!-- ajax를 이용해 댓글 영역 -->
		<div id="replyDiv"></div>
	</table>

</body>
</html>