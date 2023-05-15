<%--
  Class Name : EgovMainView.jsp 
  Description : 메인화면
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="tiles" uri="http://tiles.apache.org/tags-tiles"  %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Language" content="ko" >
<title>박상진의 홈페이지</title>

<!-- common.css  -->
<link href="<c:url value='/'/>css/common.css" rel="stylesheet" type="text/css" >

<!-- bootstrap 관련 -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Jquery 스크립트  -->
<script src="http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.12.4.min.js"></script>

<!-- CK editor 스크립트 -->
<script src="https://cdn.ckeditor.com/ckeditor5/37.0.1/classic/ckeditor.js"></script>

</head>
<style>
	#header{
		width:100%;
		height:100px;
	}
	#topnavi{
		width:100%;
		height:100px;	
	}
	#main_container{
		width: 70%;
		margin-left: 15%;
		margin-right: 15%; 
		height: 700px;
	}
	#footer{
		width:100%;
		height:150px;
	}
	a{
		text-decoration: none;
	}
</style>
<body>
<noscript>자바스크립트를 지원하지 않는 브라우저에서는 일부 기능을 사용하실 수 없습니다.</noscript>	

<div id="wrap">

	<div id="header">
		<tiles:insertAttribute name="header"/>
	</div>
	
	<div id="topnavi">
		<tiles:insertAttribute name="topnav"/>
	</div>		
	
	<div id="main_container">
		<tiles:insertAttribute name="body"/>
	</div>
	
	<div id="footer">
		<tiles:insertAttribute name="footer"/>
	</div>
</div>
</body>
</html>

