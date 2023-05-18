<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<style>
	#main_Div{
		font-size:1.4em;
		width: 100%;
		height: 500px;
	}
	#joinFormDiv{
		margin-top: 30px;
		text-align: center;
	}
	.form-control{
		width:250px;
		display: inline-block;
	}
	#idValiSpan{
		width:300px;
		display:inline-block;
	}
	#joinFormDiv span{
		width:130px;
		display:inline-block;
	}
	#joinFormDiv #idValiSpan{
		margin: 0 auto;
	}
</style>
<script>
$( document ).ready(function() {
	var url = "${pageContext.request.contextPath}/main/idValidation.do"
	$("#idIpb").on("keyup", function(){
		var idValue = $("#idIpb").val();
        $.ajax({
            type : "POST",            
            url : url,      
            data : {
            	"idValue" : idValue
            },         
            success : function(res){
            	$("#idValiSpan").text(res.res);
            	$("#idValiSpan").prop("hidden", false);
            },
            error : function(XMLHttpRequest, textStatus, errorThrown){
            	console.log("통신 실패입니다.");
            },
            dataType : 'json'
        });
	});
	
});
		
</script>

<div id="main_Div">
	<div id="joinFormDiv">
		<form:form modelAttribute="member" method="post" action="/SPP/main/join.do">
			<h4>회원가입</h4>
			<span>아이디</span><form:input path="memId" class="form-control" id="idIpb" /><br>
			<span id="idValiSpan" hidden="hidden" style="width:300px; display: block;"></span>	
			<span>비밀번호</span><form:password path="memPass" class="form-control"/><br>
			<span>이름</span><form:input path="memName" class="form-control"/><br>
			<span>메일</span><form:input path="memMail" class="form-control"/><br><br>
			<form:button class="btn btn-primary">가입하기</form:button>
		</form:form>
	</div>
</div>
