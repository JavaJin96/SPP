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
		height: 1500px;
	}
	#leftTopDiv{
		display:inline-block;
		border:1px solid black;
		width:70%;
		height:750px;
	}
	#leftDownDiv{
		display:inline-block;
		border:1px solid black;
		width:70%;
		height:750px;
	}
	#rightDiv{
		display:inline-block;
		border:1px solid black;
		width:29.5%;
		float:right;
		height:1500px;
	}
	#loginBox,#boadrDiv{
		margin-top: 50px;
		width:100%;
		height:400px;
		text-align: center;
	}
	#loginForm{
		width:100%;
	}
	.loginIpb{
		display: inline-block;
		width: 150px;
	}
	#loginForm input[type=button]{
		margin-top: 30px;
	}
	#newBdBtn{
		float:right;
		margin-bottom: 10px;
	}
</style>
<script>
$( document ).ready(function() {
	
	$("#loginBtn").on("click", function(){
		$("#loginForm").submit();
	});
	
	$("#logoutBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/main/logout.do";
	});
	
	$("#newBdBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/main/newBoard.do";
	});
	
});
		
</script>

<div id="main_Div">

	<div id="leftTopDiv">
		<div id="boadrDiv">
			<h4 style="display:inline-block;">자유게시판</h4><input type="button" value="글작성하기" class="btn btn-primary" id="newBdBtn">
			<table class="table table-bordered" id="boardTb">
				<tr>
					<th>번호</th>
					<th>제목</th>
					<th>내용</th>
					<th>작성자</th>
					<th>작성일</th>
				</tr>
				<c:if test="${fn:length(bvoList) > 0 }">
					<c:forEach items="${bvoList }" var="bvo">
						<tr>
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
			</table>
		</div>
	</div>
	
	<div id="rightDiv">
		<c:if test="${loginMember eq null}">
			<div id="loginBox">
				<form id="loginForm" action="/SPP/main/login.do" method="post"> 
					<span class="loginIpb">아이디</span><input name="loginId" class="form-control" type="text" />
					<span class="loginIpb">비밀번호</span><input name="loginPass" class="form-control" type="password" />
					<input id="joinBtn" type="button" class="btn btn-primary" value="회원가입">
					<input id="loginBtn" type="button" class="btn btn-primary" value="로그인">
				</form>
			</div>
		</c:if>
		<c:if test="${loginMember ne null }">
			<div id="loginBox">
				<h4>${loginMember.memName }(${loginMember.memId })님 환영합니다.</h4>
				<input type="button" value="로그아웃" class="btn btn-primary" id="logoutBtn">
			</div>
		</c:if>
	</div>
	
	<div id="leftDownDiv">
	
	</div>
</div>
