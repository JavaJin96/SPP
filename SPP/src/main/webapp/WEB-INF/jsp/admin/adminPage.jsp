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
		height: 700px;
		border: 1px solid black;
		padding-top:30px;
	}
	#div1,#div2,#div3,#div4{
		width:49.9%;
		height:300px;
		border: 1px solid black;
		display: inline-block;
		float :right;
	}
	#noAuthDiv{
		text-align: center;
		margin-top:50px;
	}
</style>
<script>
$( document ).ready(function() {
	
});
</script>
<div id="main_Div">
	<c:if test="${loginMember.memAuth eq 3 }">
	
		<div id="div1">
			<h4>맴버 가입 승인</h4>
			<table class="table table-warning table-bordered table-hover">
				<thead class="table table-warning table-bordered table-hover">
					<tr>
						<td>이름</td>
						<td>아이디</td>
						<td>이메일</td>
						<td>신청</td>
						<td>반려</td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(memberList) > 0}">
						<c:forEach items="${memberList }" var="member">
							<td>${member.memName }</td>
							<td>${member.memId }</td>
							<td>${member.memMail }</td>
							<td><input type="button" data-memid="${member.memId }" value="승인" id="confimBtn" class="btn btn-primary"/></td>
							<td><input type="button" data-memid="${member.memId }" value="반려" id="cancleBtn" class="btn btn-danger"/></td>
						</c:forEach>
					</c:if>
					
					<c:if test="${fn:length(memberList) <= 0}">
						<td colspan="5">조회 데이터가 없습니다.</td>
					</c:if>
				</tbody>
			</table>	
		</div>
		
		<div id="div2"></div>
		
		<div id="div3"></div>
		
		<div id="div4"></div>
	</c:if>
	<c:if test="${loginMember.memAuth ne 3 }">
		<div id="noAuthDiv">
			<h2>관리자 페이지에 접근할 수 없습니다.</h2>
		</div>
	</c:if>
</div>