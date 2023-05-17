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
	
	let today = new Date();   

	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	$("#regDate").val(year + "/" + month + "/" + date);
	
});
		
</script>

<div id="main_Div">
	<div id="boardDiv">
		<form:form modelAttribute="Board" action="/SPP/board/updateBoard.do" method="post">
			<form:input path="boTitle" placeholder="제목" class="form-control" />
			<form:input path="boWriter" id="writer" value="작성자" class="form-control" readonly="readonly" />
			<form:input path="boRegdate" id="regDate" value="작성일" class="form-control" readonly="readonly" />
			<form:textarea path="boContent" name="boardContent" id="editor" />
			<div class="btnCls">
				<button type="submit" id="modyBtn" class="btn btn-warning" >수정하기</button>
				<button type="button" id="backBtn" class="btn btn-primary" data-bono="${Board.boNo }">뒤로가기</button>
			</div>
			<form:hidden path="boNo"/>
		</form:form>
		<script>
			ClassicEditor.create(document.querySelector('#editor'), function(ev) {
				
			}).then(editor => {
				//editor.enableReadOnlyMode("editor");
			});
		</script>
	</div>
</div>
