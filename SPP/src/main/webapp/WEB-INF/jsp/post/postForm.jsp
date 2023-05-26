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
	$("#backBtn").on("click" ,function(){
		window.history.back();
	});
	
	$("#mimgDelBtn").on("click", function(){
		var url = "${pageContext.request.contextPath}/post/deleteFile.do?fileType=postImg&fileName=${resPvo.poMimg}&poNo=${resPvo.poNo}";
		location.href = url;
	});
	
	$("#attFileDelBtn").on("click", function(){
		var url = "${pageContext.request.contextPath}/post/deleteFile.do?fileType=postFile&fileName=${resPvo.poAttfile}&poNo=${resPvo.poNo}";
		location.href = url;
	});
});
</script>
<div id="main_Div">
	<div id="formDiv">
		<c:if test="${modiFlag eq 'modify' }">
			<form:form modelAttribute="resPvo" action="/SPP/post/postUpdate.do" method="post" enctype="multipart/form-data">
				<div id="mImgDiv">
					<c:if test="${resPvo.poMimg eq null }">
						<img alt="없습니다." src="${pageContext.request.contextPath }/images/icons/noimage.png" id="mImg">
					</c:if>
					<c:if test="${resPvo.poMimg ne null }">
						<img alt="없습니다." src="${pageContext.request.contextPath }/postImg/${resPvo.poMimg}" id="mImg">				
					</c:if>
				</div>
				<div id="ipbDiv">
					<form:select path="poTypeCode" id="typeSel" class="form-control">
						<c:forEach items="${postMenus }" var="type">
							<form:option value="${type.poTypeCode }">${type.poTypeName }</form:option>
						</c:forEach>
					</form:select>
					<form:input path="poTitle" id="poTitle" class="form-control"/>
					<br><br>
					<label>섬네일 이미지</label>
					<c:if test="${resPvo.poMimg eq null }">
						<input type="file" class="form-control" name="mImg">
					</c:if>
					<c:if test="${resPvo.poMimg ne null }">
						<a href="javascript:void(0);" id="mimgDown" data-fileName="${resPvo.poMimg }">${resPvo.poMimg }</a>
						<input type="button" value="삭제" class="btn btn-danger" id="mimgDelBtn"/>
						<form:hidden path="poMimg"/>
						<input type="hidden" value="poMimgY" name="poMimgFlag"/>
					</c:if>
					<br>
					<label>첨부 파일</label>
					<c:if test="${resPvo.poAttfile eq null }">
						<input type="file" class="form-control" name="attFile">
					</c:if>
					<c:if test="${resPvo.poAttfile ne null }">
						<a href="javascript:void(0);" id="attDown" data-fileName="${resPvo.poAttfile }">${resPvo.poAttfile }</a>
						<input type="button" value="삭제" class="btn btn-danger" id="attFileDelBtn"/>
						<form:hidden path="poAttfile"/>
						<input type="hidden" value="poAttfileY" name="poAttfileFlag"/>
					</c:if>
					<input type="hidden" value="${modiFlag }" name="modiFlag"/>
				</div>
				<div id="editorDiv">
					<form:textarea path="poContent" id="editor"/>
					<script>
						ClassicEditor.create(document.querySelector('#editor'));
					</script>
				</div>
				<div id="btnDiv">
					<form:button class="btn btn-primary" >수정하기</form:button>
					<form:hidden path="poNo" />
					<input type="button" value="뒤로가기" class="btn btn-danger backBtn"/>
				</div>
			</form:form>
		</c:if>
		<c:if test="${modiFlag ne 'modify'}">
			<form:form modelAttribute="pvo" action="/SPP/post/insertPost.do" method="post" enctype="multipart/form-data">
				<div id="mImgDiv">
					<img alt="없습니다." src="${pageContext.request.contextPath }/images/icons/noimage.png" id="mImg">
				</div>
				<div id="ipbDiv">
					<form:select path="poTypeCode" id="typeSel" class="form-control">
						<c:forEach items="${postMenus }" var="type">
							<form:option value="${type.poTypeCode }">${type.poTypeName }</form:option>
						</c:forEach>
					</form:select>
					<form:input path="poTitle" id="poTitle" class="form-control"/>
					<br><br>
					<label>섬네일 이미지</label><input type="file" class="form-control" name="mImg">
					<br>
					<label>첨부 파일</label><input type="file" class="form-control" name="attFile">
				</div>
				<div id="editorDiv">
					<form:textarea path="poContent" id="editor"/>
					<script>
						ClassicEditor.create(document.querySelector('#editor'));
					</script>
				</div>
				<div id="btnDiv">
					<form:button class="btn btn-primary">등록하기</form:button>
					<input type="button" value="뒤로가기" class="btn btn-danger backBtn"/>
				</div>
			</form:form>
		</c:if>
	</div>	
</div>