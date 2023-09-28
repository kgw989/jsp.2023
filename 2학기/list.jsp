<%@page import="cs.dit.board.BoardDto"%>
<%@page import="cs.dit.board.BoardDao"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix ="c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix ="fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>  

<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <title>게시판 목록</title>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
   <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
   <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
   <div class="container"><br>   
   <h2 class="text-center font-weight-bold">게시판 목록</h2>
   <br>
   <table class="table table-hover">
      <tr>
         <th>num</th>
         <th>subject</th>
         <th>writer</th>
         <th>regDate</th>
      </tr>

      <c:forEach var='dto' items='${dtos}'>
         <tr>
            <td>${dto.bcode }</td>
            <td><a href="updateForm.do?bcode=${dto.bcode}">${dto.subject}</a></td>
            <td>${dto.writer}</td>
            <td><fmt:formatDate value="${dto.regDate}"/></td>
         </tr>
      </c:forEach>
   </table>
   <br>
   <input type="button" value ="홈으로" onclick ="location.href='index.jsp'">
   <input type="button" value ="게시글 등록" onclick ="location.href='insertForm.jsp'">
   </div>
   
   <div class="d-flex justify-content-center">
	  <ul class="pagination">
	  
	  <c:if test="${startNum>1}">
	  		<li class="page-item"><a class="page-link" href="list.do?=${startNum-1}">Previous</a></li>
	  </c:if>
	  <c:if test="${startNum <=1}">
	  		<li class="page-item"><a class="page-link" style="color:gray" onclick="alert('이전 페이지가 없습니다!')" href="#">Previous</a></li>
	  </c:if>
	  <c:forEach var="i" begin="0" end="4" step="1">
	  	<c:if test="${startNum + i <= lastNum}">
	  		<c:if test="${startNum+i == p}"></c:if>
	  	</c:if>
	  </c:forEach>
    	<li class="page-item"><a class="page-link" href="#">1</a></li>
    	<li class="page-item"><a class="page-link" href="#">2</a></li>
    	<li class="page-item"><a class="page-link" href="#">3</a></li>
    	<li class="page-item"><a class="page-link" href="#">Next</a></li>
  </ul>
   </div>   
</body>
</html>