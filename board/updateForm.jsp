<%@page import="cs.dit.board.BoardDao"%>
<%@page import="cs.dit.board.BoardDto"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>  
<%@ page import = "java.util.List, java.sql.Date" %>

<%
		request.setCharacterEncoding("utf-8");
		
		int bcode = Integer.parseInt(request.getParameter("bcode"));
		
		BoardDto dto = new BoardDto();
		BoardDao dao = new BoardDao();
		
		//6. BoardDao에 정의된 selectOne 메소드를 호출하여 원하는 레코드를 dto에 저장하시오.
		dto = dao.selectOne(bcode);
		 
		
		pageContext.setAttribute("dto", dto);
%> 
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
 	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	
	<title>게시판</title>
</head>
<body>  
<div class="container">
	<h2 class="text-center font-weight-bold">상세보기</h2>
	<br/>
	<form action="update.do" method="post">
		<input type="hidden" name="bcode" value="${dto.bcode}">
		<table class="table table-striped table-hover">
			<tr>
				<th>bcode</th><td>${dto.bcode}</td>
				<th>subject</th><td><input type="text" value="${dto.subject}" name="subject"></td>
			</tr>
			<tr>
				<th>content</th>
				<td colspan="3"><textarea rows="10" cols="80" name="content">${dto.content}</textarea></td>	
			</tr>
			<tr>
				<th>writer</th><td><input type="text" value="${dto.writer}" name="writer"></td>
				<th>regDate</th><td><input type="text" value="${dto.regDate}" name="regDate"></td>
			</tr>
			<tr>
				<th>기존파일</th><td><a download href="/uploadfiles/${dto.filename}">${dto.filename}</a></td>
				<th>변경파일</th><td><input type="file" class="form-control" id="filename" name="filename"></td>
			</tr>
			<tr>
				<td colspan="4">
					<input type="submit" value ="게시글 수정" >
					<input type="button" value ="게시글 삭제" onclick ="location.href='deletePro.jsp?bcode=${dto.bcode}'">
					<input type="button" value ="게시글 목록" onclick ="location.href='list.do'">
					<input type="button" value ="게시글 등록" onclick ="location.href='insertForm.do'">
				</td>
			</tr>
		</table><br>
	</form>
	<script>
	
		var xhr1 = new XMLHttpRequest();
		var bcode = document.getElementById("bcode").value;
		
		function listComments(){
			var commnetsTable = document.getElementById("commentsTable");'
			commnetsTable = "";
			
			
			//상태가 변화되었을 때 실행
			xhr1 onreadystatechange = function(){
				if(this.redystate==4 && this.status==200)
					var json = this.responseText;
					var list = JSON.parse(json);
					
					for(var i in list){
						var row = commentsTable.insertRow(0);
						var cell0 = row.insertCell(0);
						var cell1 = row.insertCell(1);
						var cell2 = row.insertCell(2);
						
						cell0.innerHTML = list[i].ccode;  
						cell1.innerHTML = list[i].content;
						cell2.innerHTML = list[i].regdate;
					}
			}
			
		};
		xhr1.open("POST", "/board-mvc-comments/cList.ct", true);
		xhr1.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
		xhr1.send("bcode=" + bcode);
		
		function insertComments(){
			
		}
		
		// 이 파일이 실행되자마자 listComments 함수를 호출
		window.onload = function(){listComments()};
	</script>
</div>
	<div id="commentsTable">
		<table>
			<tr>
			<th>댓글 : </th><td><input type="text" size="80" id="comments"></td>
			<td><button onclick="">댓글 저장</button></td>
			</tr>
		</table>
		<table>
			<tbody id="commentsTable">
			</tbody>
		</table>
	</div>
</body>
</html>