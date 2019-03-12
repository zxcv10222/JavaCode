<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" href="../resources/css/board.css">
<meta charset="UTF-8">
<title>[게시판 수정하기]</title>
</head>
<body>

	<h1>[게시판 수정하기]</h1>
	<!-- 파일 전송시  -->
	<form action="edit" method="post" id="writeForm"
		enctype="multipart/form-data">
		<input type="hidden" name="s_boardnum" value="${board.boardnum }">
		<table>
			<tr>
				<th>제목
				<td><input type="text" id="s_title" name="s_title" size="48"
					value="${board.title }">
			</tr>
			<tr>
				<th>내용
				<td><textarea rows="22" cols="50" name="s_content" id="s_content">${board.s_content}</textarea>
			</tr>
			<tr>
				<th>파일첨부 ${board.originalfile }
				<td><input type="file" name="upload" size="30">
				
			</tr>

		</table>
		<p align="center">
			<input type="submit" value="저장">
	</form>
</body>
</html>