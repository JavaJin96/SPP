<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>

<style>
	#dc_Div{
		font-size:1.4em;
		width: 100%;
		height: 1500px;
	}
	#leftTopDiv{
		display:inline-block;
		width:29.5%;
		height:1500px;
	}
	#rightDiv{
		display:inline-block;
		width:70%;
		float:right;
		height:1500px;
	}
	#fileUploadDiv{
		text-align: center;
	}
	#fileUploadForm{
		margin-top: 30px;
	}
	#fileDownloadDiv h3{
		text-align: center;
		margin-top: 30px;
	}
</style>
<script>
	$( document ).ready(function() {
		
		$("#goLogin").on("click", function(){
			location.href = "${pageContext.request.contextPath}/main/main.do";
		})
		/* 파일 업로드 비동기 처리용 스크립트 */
/* 		$("#subBtn").on("click", function(){
			var form = new FormData(document.getElementById('fileUploadForm'));
			var url = "${pageContext.request.contextPath}/dc/fileUpload.do";
			$.ajax({
				url: url,
				data: form,
				dataType: 'json',
				processData: false,
				contentType: false,
				type: 'POST',
				success: function (response) {
		  			alert(response);
				},error: function (jqXHR) {
		  			alert(jqXHR.responseText);
				}
			});	
		}); */
		
		$(".dlBtn").on("click", function(){
			var fileName = $(this).data("filename");
			var url = "${pageContext.request.contextPath}/dc/fileDownload.do?fileName="+fileName;
			location.href = url;
		});
		
		$(".delBtn").on("click", function(){
			var fileName = $(this).data("filename");
			var url = "${pageContext.request.contextPath}/dc/fileDelete.do?fileName="+fileName;
			location.href = url;
		});
		
	});
</script>
<div id="dc_Div">
	<c:if test="${loginMember ne null and loginMember.memAuth eq '3'}">
		<div id="leftTopDiv">
			<div id="fileUploadDiv">
				<form id="fileUploadForm" action="/SPP/dc/fileUpload.do" enctype="multipart/form-data" method="post">
					<h3>파일 업로드</h3>
					<input class="form-control" type="file" name="file1"><br>
					<button id="subBtn" type="submit" class="btn btn-primary">업로드</button>
					<!-- <input id="subBtn" type="button" class="btn btn-primary" value="업로드"> -->
				</form>
			</div>
		</div>
		
		<div id="rightDiv">
			<div id="fileDownloadDiv">
				<h3>파일 다운로드</h3>
				<table class="table">
					<tr>
						<th>파일명</th>
						<th>파일용량</th>
						<th>다운로드</th>
						<th>삭제</th>
					</tr>
					<c:if test="${fileVoList eq null}">
						<tr>
							<td colspan="4">파일이 없습니다.</td>
						</tr>
					</c:if>
					<c:if test="${fileVoList ne null}">
						<c:forEach items="${fileVoList }" var="file">
							<tr>
								<td>${file.fileName }</td>
								<td>${file.fileSize }</td>
								<td><input type="button" value="다운로드" class="btn btn-primary dlBtn" data-filename="${file.fileName }"></td>
								<td><input type="button" value="삭제" class="btn btn-primary delBtn" data-filename="${file.fileName }"></td>
							</tr>
						</c:forEach>
					</c:if>
				</table>
			</div>
		</div>
	</c:if>
	<h1> 로그인 이후 접근가능합니다.</h1>
	<input id="goLogin" class="btn btn-primary" type="button" value="로그인하러 가기" />
	
</div>
