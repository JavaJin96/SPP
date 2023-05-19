<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>

<style>
	#main_Div{
		font-size:1.4em;
		width: 100%;
		height: 1500px;
		padding-top: 25px;
	}
	#leftTopDiv{
		display:inline-block;
		width:70%;
		height:750px;
		margin-bottom: 30px;
	}
	#leftDownDiv{
		display:inline-block;
		width:70%;
		height:750px;
	}
	#rightDiv{
		display:inline-block;
		width:29.5%;
		float:right;
		height:1500px;
	}
	#loginBox,#boadrDiv{
		width:100%;
		height:400px;
		text-align: center;
	}
	#loginForm{
		width:100%;
	}
	.loginIpb{
		display: inline-block;
		width: 150px;
	}
	#loginForm input[type=button]{
		margin-top: 30px;
	}
	#newBdBtn{
		float:right;
		margin-bottom: 10px;
	}
	#leftIf{
		width:100%;
		height:750px;
		border : 1px solid rgb(224, 224, 235);
		border-radius: 3%;
		overflow: hidden;
	}
	#loginBox{
		padding-top : 40px;
		height:300px;
		border : 1px solid rgb(224, 224, 235);
		border-radius: 3%;
		margin-bottom: 20px;
	}
	#loginBox input[type=text], #loginBox input[type=password]{
		width:200px;
		display: inline-block;
	}
	#calendar{
		height:390px;
		font-size: 0.4em;
		border : 1px solid rgb(224, 224, 235);
		border-radius: 3%;
	}
	.img{
	    width: 15%;
	    height: 60px;
	    margin-right: 30px;
        margin-left: 30px;
	}
	#homePageInfoDiv{
		margin-top : 69px;
		padding-left : 30px;
		border : 1px solid rgb(224, 224, 235);
		border-radius: 3%;
	}
	#comeCountChartDiv{
		width:100%;
		height:500px;
		font-size: 0.8em;
	}
	#boadrDiv{
		padding-top:30px;
		padding-left:10px;
		padding-right:10px;
		border : 1px solid rgb(224, 224, 235);
		border-radius: 3%;
		height : 558px;
	}
	#boadrDiv th{
		color : white;
		height: 50px;
		font-size: 0.8em;
		font-weight: bold;
	}
</style> 
<script>
document.addEventListener('DOMContentLoaded', function() {
	var calendarEl = document.getElementById('calendar');
	var calendar = new FullCalendar.Calendar(calendarEl, {
		initialView: 'dayGridMonth'
	});
	calendar.render();
});
$( document ).ready(function() {
	
	am4core.ready(function() {

		// Themes begin
		am4core.useTheme(am4themes_animated);
		// Themes end

		// Create chart instance
		var chart = am4core.create("comeCountChartDiv", am4charts.XYChart);

		// Add data
		chart.data = ${chartJsonData};

		// Create axes

		var categoryAxis = chart.xAxes.push(new am4charts.CategoryAxis());
		categoryAxis.dataFields.category = "pvDate";
		categoryAxis.renderer.grid.template.location = 0;
		categoryAxis.renderer.minGridDistance = 30;

		categoryAxis.renderer.labels.template.adapter.add("dy", function(dy, target) {
		  if (target.dataItem && target.dataItem.index & 2 == 2) {
		    return dy + 25;
		  }
		  return dy;
		});

		var valueAxis = chart.yAxes.push(new am4charts.ValueAxis());

		// Create series
		var series = chart.series.push(new am4charts.ColumnSeries());
		series.dataFields.valueY = "pvIp";
		series.dataFields.categoryX = "pvDate";
		series.name = "pvIp";
		series.columns.template.tooltipText = "{categoryX}: [bold]{valueY}[/]";
		series.columns.template.fillOpacity = .8;

		var columnTemplate = series.columns.template;
		columnTemplate.strokeWidth = 2;
		columnTemplate.strokeOpacity = 1;

		}); // end am4core.ready()
	
	$("#loginBtn").on("click", function(){
		$("#loginForm").submit();
	});
	
	$("#logoutBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/main/logout.do";
	});
	
	$("#newBdBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/board/boardForm.do";
	});
	
	$(".boardTr").on("click" , function(){
		var boNo = $(this).data("bono");
		location.href = "${pageContext.request.contextPath }/board/boardDtl.do?boNo=" + boNo;
	});
	
	$("#adminBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/admin/adminMain.do";
	});
	
	$("#joinBtn").on("click", function(){
		location.href = "${pageContext.request.contextPath}/main/joinForm.do";
	});
	
});
		
</script>

<div id="main_Div">

	<div id="leftTopDiv">
		<iframe id="leftIf" src="https://javajin96.github.io/Mypage/Mypage/WebContent/index.html"></iframe>
	</div>
	
	<div id="rightDiv">
		<c:if test="${loginMember eq null}">
			<div id="loginBox">
				<form id="loginForm" action="/SPP/main/login.do" method="post"> 
					<span class="loginIpb">아이디</span><input name="loginId" class="form-control" type="text" />
					<span class="loginIpb">비밀번호</span><input name="loginPass" class="form-control" type="password" />
					<input id="joinBtn" type="button" class="btn btn-primary" value="회원가입">
					<input id="loginBtn" type="button" class="btn btn-primary" value="로그인">
				</form>
			</div>
		</c:if>
		<c:if test="${loginMember ne null }">
			<div id="loginBox">
				<h4>${loginMember.memName }(${loginMember.memId })님 환영합니다.</h4>
				<input type="button" value="로그아웃" class="btn btn-primary" id="logoutBtn">
				<c:if test="${loginMember.memAuth eq 3 }">
					<input type="button" value="관리자기능" class="btn btn-primary" id="adminBtn">
				</c:if>
				<br><br>
				<img alt="" src="${pageContext.request.contextPath }/images/icons/heart.png" class="img">
				<img alt="" src="${pageContext.request.contextPath }/images/icons/location.png" class="img">
				<img alt="" src="${pageContext.request.contextPath }/images/icons/mailbox.png" class="img">
<%-- 				<br><br>
				<img alt="" src="${pageContext.request.contextPath }/images/icons/menu.png" class="img">
				<img alt="" src="${pageContext.request.contextPath }/images/icons/search.png" class="img">
				<img alt="" src="${pageContext.request.contextPath }/images/icons/setting.png" class="img"> --%>
			</div>
		</c:if>
		<div id='calendar'></div>
		<div id="homePageInfoDiv">
			<h6>총 방문자수 : ${totCnt }</h6>
			<h6>오늘 방문자수 : ${todayCnt }</h6>
			<div id="comeCountChartDiv">
				임시지만 차트 들어갈 곳.
			</div>
		</div>
	</div>
	
	<div id="leftDownDiv">
		<div id="boadrDiv">
			<h4 style="display:inline-block;"><a href="${pageContext.request.contextPath }/board/main.do">자유게시판</a></h4>
			<input type="button" value="글작성하기" class="btn btn-primary" id="newBdBtn">
			<table class="table table-warning table-bordered table-hover" id="boardTb">
				<thead class="table table-bordered table-hover" style="background-color:rgb(44,62,80); color:white;">
					<tr>
						<th>번호</th>
						<th>제목</th>
						<th>내용</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
				<c:if test="${fn:length(bvoList) > 0 }">
					<c:forEach items="${bvoList }" var="bvo">
						<tr data-boNo="${bvo.boNo }" class="boardTr">
							<td>${bvo.boNo }</td>
							<td>${bvo.boTitle }</td>
							<td>${bvo.boContent }</td>
							<td>${bvo.boWriter }</td>
							<td>${bvo.boRegdate }</td>
						</tr>
					</c:forEach>
				</c:if>
				<c:if test="${fn:length(bvoList) <= 0 }">
					<tr>
						<td colspan="5">게시글이 없습니다.</td>
					</tr>
				</c:if>
				</tbody>
			</table>
		</div>
	</div>
</div>
