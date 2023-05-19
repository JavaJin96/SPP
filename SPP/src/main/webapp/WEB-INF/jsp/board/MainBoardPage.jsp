<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>

<style>
	#main_Div{
		font-size:1.8em;
		width: 100%;
		height: 500px;
	}
	#boardDiv{
		margin-top: 30px;
	}
	#newBdBtn{
		float:right;
		margin-bottom: 10px;
	}
	#boardDiv th{
		color : white;
		height: 50px;
		font-size: 0.8em;
		font-weight: bold;
	}
</style>
<script>
$( document ).ready(function() {
	
	$("#newBdBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/board/boardForm.do";
	});
		
	$(".boardTr").on("click" , function(){
		var boNo = $(this).data("bono");
		location.href = "${pageContext.request.contextPath }/board/boardDtl.do?boNo=" + boNo;
	});
	
});
		
</script>

<div id="main_Div">
	<div id="boardDiv">
		<h4 style="display:inline-block;"><a href="${pageContext.request.contextPath }/board/main.do">자유게시판</a></h4>
		<input type="button" value="글작성하기" class="btn btn-primary" id="newBdBtn">
			<table class="table table-warning table-bordered table-hover" id="boardTb">
				<thead class="table table-bordered table-hover" style="background-color:rgb(44,62,80); color:white;">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(bvoList) > 0 }">
					<c:forEach items="${bvoList }" var="bvo">
						<tr data-boNo="${bvo.boNo }" class="boardTr">
							<td>${bvo.boNo }</td>
							<td>${bvo.boTitle }</td>
							<td>${bvo.boContent }</td>
							<td>${bvo.boWriter }</td>
							<td>${bvo.boRegdate }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(bvoList) <= 0 }">
					<tr>
						<td colspan="5">게시글이 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
	</div>
</div>
