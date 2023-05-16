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
	.form-control{
		display: inline-block;
	}
	.form-control[name="boardTitle"]{
		width : 70%;
	}
	.form-control[name="boardWriter"]{
		width : 14.2%;
	}
	.form-control[name="boardRegdate"]{
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
</style>
<script>
$( document ).ready(function() {
	
	let today = new Date();   

	let year = today.getFullYear(); // 년도
	let month = today.getMonth() + 1;  // 월
	let date = today.getDate();  // 날짜
	$("#regDate").val(year + "/" + month + "/" + date);
	
	if(${loginMember.memName ne null}){
		$("#writer").val("${loginMember.memName}(${loginMember.memId})");
	}
	
});
		
</script>

<div id="main_Div">
	<div id="boardDiv">
		<form action="/SPP/main/submitBoard.do" method="post">
			<input type="text" placeholder="제목" class="form-control" name="boardTitle" required="required"/>
			<input type="text" id="writer" value="작성자" class="form-control" name="boardWriter" readonly="readonly" required="required"/>
			<input type="text" id="regDate" value="작성일" class="form-control" name="boardRegdate" readonly="readonly" required="required"/>
			<textarea name="boardContent" id="editor"></textarea>
			<script>
				ClassicEditor.create(document.querySelector('#editor'));
			</script>
			<div class="btnCls">
				<button type="submit" class="btn btn-primary" >작성하기</button>
				<button type="reset" class="btn btn-primary" >초기화</button>
			</div>
		</form>
	</div>
</div>
