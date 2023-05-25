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
		height: 1500px;
		/* border: 1px solid black; */
		padding-top:30px;
		padding-left:30px;
		padding-right:30px
	}
	#formDiv{
		width:100%;
		height:1400px;
		padding-top:30px;
		padding-bottom:30px;
		padding-left:30px;
		padding-right:30px;
		border : 3px solid rgb(224, 224, 235);
		border-radius: 20px;
	}
	.ck-content{
		height:1000px;
	}
	#mImg{
		display:inline-block;
		width:205px;
		height:200px;
	}
	#mImgDiv{
		display:inline-block;
		float:left;
		width:17%;
		height:200px;
	}
	#ipbDiv{
		padding-left:20px;
		padding-top:30px;
		display:inline-block;
		float:left;
		width:83%;
		height:200px;
		font-size:0.65em;
		
	}
	#typeSel{
		width:200px;
		height:40px;
	}
	#poTitle{
		width:78%;
		height:40px;
	}
	#ipbDiv label{
		width:200px;
		margin-bottom: 13px;
	}
	#editorDiv{
		width:100%;
		height:1050px;
		display: inline-block;
	}
	#btnDiv{
		width:100%;
		height:100px;
		text-align:center;
	}
	.form-control{
		display: inline-block;
	}
	input[type=file]{
		width:770px;
	}
</style>

<script>
$( document ).ready(function() {
	$("#typeSel").prop("disabled", "disabled");
	$("#poTitle").attr("readonly", "readonly");
	
	
	$("#mimgDown").on("click", function(){
		var fileName = $(this).data("filename");
		var fileType = "postImg";
		var url = "${pageContext.request.contextPath}/post/downloadFile.do?fileName="+fileName+"&fileType="+fileType
		
		location.href = url;
/* 		$.ajax({
			url: url,
			method: "post",
			success(res){
				console.log(res);
			},
			error(xhr){
				console.log(xhr);
			},
			dataType:"json"
		}); */
	});
	
	$("#attDown").on("click", function(){
		var fileName = $(this).data("filename");
		var fileType = "postFile";
		var url = "${pageContext.request.contextPath}/post/downloadFile.do?fileName="+fileName+"&fileType="+fileType
		
		location.href = url;
	});
	
	$("#modifyBtn").on("click", function(){
		var poNo = $(this).data("pono");
		var url = "${pageContext.request.contextPath}/post/postModifyForm.do?poNo="+poNo;
		location.href = url 
	});
	
	$("#backBtn").on("click", function(){
		window.history.back();
	});
});
</script>
<div id="main_Div">
	<div id="formDiv">
		
		<form:form modelAttribute="resPvo" action="/SPP/post/insertPost.do" method="post" enctype="multipart/form-data">
			<div id="mImgDiv">
				<c:if test="${resPvo.poMimg eq null }">
					<img alt="없습니다." src="${pageContext.request.contextPath }/images/icons/noimage.png" id="mImg">
				</c:if>
				
				<c:if test="${resPvo.poMimg ne null }">
					<img alt="없습니다." src="${pageContext.request.contextPath }/postImg/${resPvo.poMimg}" id="mImg">				
				</c:if>
			</div>
			<div id="ipbDiv">
				<form:select path="poTypeCode" id="typeSel" class="form-control" >
					<c:forEach items="${postMenus }" var="type">
						<form:option value="${type.poTypeCode }" >${type.poTypeName }</form:option>
					</c:forEach>
				</form:select>
				<form:input path="poTitle" id="poTitle" class="form-control" />
				<br><br>
				<label>섬네일 이미지</label>
				<%-- <input type=button id="mimgDown" value="${resPvo.poMimg }" class="btn btn-primary" data-fileName="${resPvo.poMimg }"/> --%>
				<a href="javascript:void(0);" id="mimgDown" data-fileName="${resPvo.poMimg }">${resPvo.poMimg }</a>
				<br>
				<label>첨부 파일</label><a href="javascript:void(0);" id="attDown" data-fileName="${resPvo.poAttfile }">${resPvo.poAttfile }</a>
			</div>
			<div id="editorDiv">
				<form:textarea path="poContent" id="editor"/>
				<script>
					ClassicEditor.create(document.querySelector('#editor'), function(ev) {
						
					}).then(editor => {
						editor.enableReadOnlyMode("editor");
					});
				</script>
			</div>
			<div id="btnDiv">
				<c:if test="${loginMember.memAuth eq 3 }">
					<input type="button" value="수정하기" class="btn btn-primary" id="modifyBtn" data-pono="${resPvo.poNo }"/>
				</c:if>
				<input type="button" value="뒤로가기" class="btn btn-danger" id="backBtn"/>
			</div>
		</form:form>
	</div>	
</div>