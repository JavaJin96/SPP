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
		height: 500px;
	}
	.form-control{
		display: inline-block;
	}
	.form-control[name="boTitle"]{
		width : 70%;
	}
	.form-control[name="boWriter"]{
		width : 14.2%;
	}
	.form-control[name="boRegdate"]{
		width : 14.2%;
	}
	.btnCls{
		text-align: center;
	}
	#boardDiv{
		margin-top: 30px;
	}
	.ck-editor__editable{ 
     	min-height:470px; 
     }
     .btn{
     	margin-top : 10px;
     } 
</style>
<script>
$( document ).ready(function() {
	
	$("#boTitle").attr("readonly", "readonly");
	$("#writer").attr("readonly", "readonly");
	$("#regDate").attr("readonly", "readonly");
	
	$("#backBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/board/main.do";
	});
	
	$("#modyBtn").on("click", function(){
		$("#updateForm").submit();
	});
	
	$("#delBtn").on("click", function(){
		$("#deleteForm").submit();
	});
	
});
		
</script>

<div id="main_Div">
	<div id="boardDiv">
		<form:form modelAttribute="Board">
			<form:input path="boTitle" placeholder="제목" class="form-control" readonly="readonly"/>
			<form:input path="boWriter" id="writer" value="작성자" class="form-control" readonly="readonly" />
			<form:input path="boRegdate" id="regDate" value="작성일" class="form-control" readonly="readonly" />
			<form:textarea path="boContent" name="boardContent" id="editor" readonly="readonly"/>
		</form:form>
		<form hidden="hidden" id="updateForm" method="post" action="/SPP/board/updateBoardForm.do">
			<input type="text" value="${Board.boNo }" name="boNo">
		</form>
		<form hidden="hidden" id="deleteForm" method="post" action="/SPP/board/deleteBoard.do">
			<input type="text" value="${Board.boNo }" name="boNo">
		</form>
		<div class="btnCls">
			<input type="button" id="backBtn" class="btn btn-primary" value="뒤로가기"/>
			<c:if test="${loginMember.memId eq Board.boWriter or loginMember.memAuth eq 3}">
				<input type="button" id="modyBtn" class="btn btn-warning" value="수정하기"/>
				<input type="button" id="delBtn" class="btn btn-danger" value="삭제하기"/>
			</c:if>
		</div>
		<script>
			ClassicEditor.create(document.querySelector('#editor'), function(ev) {
				
			}).then(editor => {
				editor.enableReadOnlyMode("editor");
			});
		</script>
	</div>
</div>
