<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

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
	
	$("#confimBtn").on("click", function(){
		var memId = $("#confimBtn").data("memid");
		location.href = "${pageContext.request.contextPath}/admin/confrimMember.do?memId=" + memId;
	});
	
	$("#cancleBtn").on("click", function(){
		var memId = $("#cancleBtn").data("memid");
		location.href = "${pageContext.request.contextPath}/admin/deleteMember.do?memId=" + memId;
	});
	
	$(".authSel").on("change" ,function(){
		var memId =$(this).data("memid");
		$("#"+memId).submit();
	});
	
	$(".saveBtn").on("click", function(){
		var code = $(this).data("code");
		var codeVal = $("input[id="+code+"]").val();
		
		var nameVal = $("input[id="+code+"name]").val();
		location.href = "${pageContext.request.contextPath}/admin/updateMenu.do?code="+codeVal+"&name="+nameVal;
	});
	
	$(".delBtn").on("click", function(){
		var code = $(this).data("code");
		var name = $(this).data("name");
		location.href = "${pageContext.request.contextPath}/admin/deleteMenu.do?code="+code+"&name="+name;
	});
	
	$("#insertBtn").on("click", function(){
		var insertCode = $("#insertCode").val();
		var insertName = $("#insertName").val();
		location.href = "${pageContext.request.contextPath}/admin/insertMenu.do?code="+insertCode+"&name="+insertName;
	});
	
	$("#cancelBtn").on("click", function(){
		
	});
	
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
					<c:if test="${fn:length(joinMemberList) > 0}">
						<c:forEach items="${joinMemberList }" var="member">
							<tr>
								<td>${member.memName }</td>
								<td>${member.memId }</td>
								<td>${member.memMail }</td>
								<td><input type="button" data-memid="${member.memId }" value="승인" id="confimBtn" class="btn btn-primary"/></td>
								<td><input type="button" data-memid="${member.memId }" value="반려" id="cancleBtn" class="btn btn-danger"/></td>
							</tr>
						</c:forEach>
					</c:if>
					
					<c:if test="${fn:length(joinMemberList) <= 0}">
						<tr>
							<td colspan="5">조회 데이터가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>	
		</div>
		
		<div id="div2">
			<h4>맴버 권한 관리</h4>
			<table class="table table-warning table-bordered table-hover">
				<thead class="table table-warning table-bordered table-hover">
					<tr>
						<td>이름</td>
						<td>아이디</td>
						<td>이메일</td>
						<td>권한Level</td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(authMemberList) > 0}">
						<c:forEach items="${authMemberList }" var="member">
							<tr>
								<td>${member.memName }</td>
								<td>${member.memId }</td>
								<td>${member.memMail }</td>
								<td>
									<form action="/SPP/admin/authManagement.do" method="get" id="${member.memId }">
									<select class="authSel" name="memAuth" data-memid="${member.memId }" style="width:100%;">
										<option value="1" 
											<c:if test="${member.memAuth eq 1}">selected</c:if>>1
										</option>
										<option value="2"
											<c:if test="${member.memAuth eq 2}">selected</c:if>>2
										</option>
										<option value="3"
											<c:if test="${member.memAuth eq 3}">selected</c:if>>3
										</option>
									</select>
									<input type="text" name="memId" hidden="hidden" value="${member.memId }" "/>
									</form>
								</td>
							</tr>
						</c:forEach>
					</c:if>
					
					<c:if test="${fn:length(authMemberList) <= 0}">
						<tr>
							<td colspan="4">조회 데이터가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>	
		</div>
		<div id="div3"></div>
		
		<div id="div4">
			<h4>POST 메뉴 관리</h4>
			<table class="table table-warning table-bordered table-hover">
				<thead class="table table-warning table-bordered table-hover">
					<tr>
						<td>메뉴코드</td>
						<td>메뉴명</td>
						<td>저장</td>
						<td>삭제</td>
					</tr>
				</thead>
				<tbody>
					<c:if test="${fn:length(menuList) > 0}">
						<c:forEach items="${menuList }" var="menu">
							<tr>
								<td><input type="text" value="${menu.poTypeCode }" class="codeIpb" id="${menu.poTypeCode }"></td>
								<td><input type="text" value="${menu.poTypeName }" class="nameIpb" id="${menu.poTypeCode }name"></td>
								<td><input type="button" value="저장" class="btn btn-primary saveBtn" data-code="${menu.poTypeCode }" data-name="${menu.poTypeName }"></td>
								<td><input type="button" value="삭제" class="btn btn-danger delBtn" data-code="${menu.poTypeCode }" data-name="${menu.poTypeName }"></td>
							</tr>
						</c:forEach>
					</c:if>
					
					<c:if test="${fn:length(menuList) <= 0}">
						<tr>
							<td colspan="3">조회 데이터가 없습니다.</td>
						</tr>
					</c:if>
					<tr>
						<td><input type="text" name="insertCode" id="insertCode" /></td>
						<td><input type="text" name="insertName" id="insertName" /></td>
						<td><input type="button" id="insertBtn" value="등록하기" class="btn btn-primary"/></td>
						<td><input type="button" id="cancelBtn" value="취소하기" class="btn btn-danger"/></td>
					</tr>
				</tbody>
			</table>	
		</div>
	</c:if>
	<c:if test="${loginMember.memAuth ne 3 }">
		<div id="noAuthDiv">
			<h2>관리자 페이지에 접근할 수 없습니다.</h2>
		</div>
	</c:if>
</div>