<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<script >
	function check() {
		


	s_boardNum
	s_title
	s_content
	s_tag
	s_fileName
	s_insertDate
	s_updateDate
	s_custid

	
	
</script>
<meta charset="UTF-8">
<title>[방명록 글쓰기]</title>
</head>
<body>
<h1>방명록 글쓰기</h1>
<form action="boardWrite" method="post" onsubmit="return check()">
	<table>
		<tr>
			<td>s_boardNum
			<td><input type="text" name="s_boardNum" id="s_boardNum">
		</tr>
		<tr>
			<td>s_title
			<td><input type="text" name="s_title" id="s_title">
		</tr>
		<tr>
			<td>s_content
			<td><input type="text" name="s_content" id="s_content">
		</tr>
		<tr>
			<td>s_tag
				<td><input type="text" name="s_tag" id="s_tag">
			</tr>
		<tr>
			<td>s_fileName
				<td><input type="text" name="s_fileName" id="s_fileName">
			</tr>									
		<tr>
			<td>s_insertDate
			<td><input type="text" name="s_insertDate" id="s_insertDate">
		</tr>
		<tr>
			<td>s_updateDate
			<td><input type="password" name="s_updateDate" id="s_updateDate">
		</tr>	
		<tr>
			<td>s_custid
			<td><input type="password" name="s_custid" id="s_custid">
		</tr>		
	</table>
	
	<input type="submit" value="저장">
</form>

</body>
</html>