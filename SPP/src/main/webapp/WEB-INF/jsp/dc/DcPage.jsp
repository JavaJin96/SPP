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
		border:1px solid black;
		width:29.5%;
		height:1500px;
	}
	#rightDiv{
		display:inline-block;
		border:1px solid black;
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

<div id="dc_Div">

	<div id="leftTopDiv">
		<div id="fileUploadDiv">
			<form id="fileUploadForm">
				<h3>파일 업로드</h3>
				<input class="form-control" type="file"><br>
				<input type="button" class="btn btn-primary" value="업로드">
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
				</tr>
				<c:if test="${tempTableData eq null}">
					<tr>
						<td colspan="3">파일이 없습니다.</td>
					</tr>
				</c:if>
				<c:if test="${tempTableData ne null}">
					<c:forEach items="${tempTableData }" var="tableData">
						<tr>
							<td>${tableData.name }</td>
							<td>${tableData.size }</td>
							<td><input type="button" value="다운로드"></td>
						</tr>
					</c:forEach>
				</c:if>
			</table>
		</div>
	</div>
</div>
