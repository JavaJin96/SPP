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
	#leftDiv{
		display:inline-block;
		width:75%;
		height:1470px;
		float:left;
		/*  border:1px solid black; */
	}
	#rightDiv{
		display:inline-block;
		width:24.2%;
		height:1470px;
		float:left;
		padding-left: 10px;
		/*  border:1px solid black; */
	}
	
	
	
	.postDiv{
		width:100%;
		height:200px;
		display:inline-block;
		float:left;
		margin-bottom:30px;
		overflow:hidden;
		
		border : 3px solid rgb(224, 224, 235);
		border-radius: 20px;
	}
	.imgDiv{
		display:inline-block;
		float:left;
		width:25%;
		height:200px;
		
		border-right:1px solid black;
	}
	.contentDiv{
		display:inline-block;
		float:left;
		width:73.9%;
		height:200px;
		text-align: center;
		padding-left: 20px;
		
		/*  border:1px solid red; */
	}
	.paging{
		text-align: center;
	}
	.paging ul{
		display: inline-block;
		text-align: center;	
	}
	.paging li{
		display: inline-block;
		text-align: center;
	}
	
	#searchDiv{
		width:100%;
		height:200px;
		text-align:center;
		float:left;
		padding-top:20px;
		padding-left:30px;
		padding-right:30px;
		font-size:0.8em;
		margin-bottom:30px;
		
		border : 1px solid rgb(224, 224, 235);
		border-radius: 20px;
	}
	#searchSel{
		width:50%;
		height:40px;
		margin-bottom: 10px;
	}
	#searchCon{
		width:100%;
		height:40px;
		margin-bottom: 10px;
	}
	
	#menuDiv{
		width:100%;
		height:1000px;
		text-align:center;
		float:left;
		padding-top:20px;
		font-size:0.8em;
		
		border : 1px solid rgb(224, 224, 235);
		border-radius: 20px;
	}
	.img{
		width:100%;
		height:200px;
	}
	.titleSpan{
		display: inline-block;
		float:left;
		font-weight: bold;
	}
	.typeSpan{
		display: inline-block;
		float:left;
	}
	.dateSpan{
		display: inline-block;
		float:right;
		font-size: 0.7em;
	}
	.menuAtag{
		font-weight: bold;
	}
	.paging img{
		width:25px;
		margin-right: 5px;
	}
</style>

<script>
$( document ).ready(function() {
	$(".postDiv").on("mouseover", function(){
		$(this).css("background","rgb(194, 194, 214)");
	});
	
	$(".postDiv").on("mouseout", function(){
		$(this).css("background","none");
	});
	
	$(".postDiv").on("click", function(){
		var poNo = $(this).data('pono');
		location.href = "${pageContext.request.contextPath}/post/postDtl.do?poNo="+poNo;
	});
	
	$("#newPost").on("click", function(){
		location.href = "${pageContext.request.contextPath}/post/postForm.do";
	});
	
	$(".menuAtag").on("click", function(){
		var url = "";
		var code = $(this).data("code");
		if(code == "all") {
			url = "${pageContext.request.contextPath}/post/main.do";
		}else if(code != "all"){
			url = "${pageContext.request.contextPath}/post/main.do?pageType="+code;
		}
		location.href = url;
	});
	
	$("#postMenuBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/admin/adminMain.do";
	});
	
	
});
function linkPage(pageNo){
	var pageType = "${pageType}";
	if(pageType == "undefined" || pageType == ""){
		location.href = "${pageContext.request.contextPath}/post/main.do?pageNo="+pageNo;
	}else if(pageType != "undefined"){
		location.href = "${pageContext.request.contextPath}/post/main.do?pageNo="+pageNo+"&pageType="+pageType;
	}
}
</script>
<div id="main_Div">

	<div id="leftDiv">
		<c:if test="${fn:length(postList) > 0  }">
			<c:forEach items="${postList }" var="post">
			<div class="postDiv" data-pono="${post.poNo }">
				<div class="imgDiv">
					<c:if test="${post.poMimg eq null }">
						<img alt="test" src="${pageContext.request.contextPath }/images/icons/noimage.png" class="img">
					</c:if>
					<c:if test="${post.poMimg ne null }">
						<img alt="test" src="${pageContext.request.contextPath }/postImg/${post.poMimg}" class="img">
					</c:if>
				</div>
				<div class="contentDiv" >
					<span class="typeSpan">    [${post.poTypeName }]</span>
					<span class="titleSpan">${post.poTitle }</span>
					<span class="dateSpan">${post.poRegdate }</span>
					<br>
					<hr style="display: block;">
					<h5>${post.poContent }</h5>
				</div>
			</div>
			</c:forEach>
		</c:if>
		<c:if test="${fn:length(postList) <= 0  }">
			<h3>게시글이 없습니다.</h3>
		</c:if>
		
		<div class="paging">
			<ul class="pagination">
				<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="linkPage" />
			</ul>
		</div>
	</div>
	
	<div id="rightDiv">
		<div id="searchDiv">
			<form action="/SPP/post/main.do" method="get">
				 <select name="searchType" id="searchSel" class="form-control">
					<option value="title" >제목</option>
					<option value="content">내용</option>
					<option value="tiContent">제목+내용</option>
				</select>
				<input type="text" name="searchCon" id="searchCon" placeholder="검색어를 입력해주세요." class="form-control">
				<input type="submit" class="btn btn-primary" value="검색" >
				<c:if test="${loginMember.memAuth eq 3 }">
					<input type="button" class="btn btn-primary" id="newPost" value="글작성하기">
				</c:if>
				<c:if test="${pageType ne null }">
					<input type="hidden" value="${pageType }" name="pageType"/>
				</c:if>
			</form>
		</div>
		<div id="menuDiv">
			<input type="button" class="btn btn-warning" id="postMenuBtn" value="분류관리">
			<hr style="display:inline-block; width:100%;">
			<br>
			<a class="menuAtag" data-code="all">전체</a>
			<br>
			<c:forEach items="${postMenus }" var="menu">
				<a class="menuAtag" data-code="${menu.poTypeCode }">${menu.poTypeName }></a>
				<br>
			</c:forEach>
		</div>
	</div>
	
</div>