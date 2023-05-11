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
		height: 1500px;
	}
	#leftTopDiv{
		display:inline-block;
		border:1px solid black;
		width:70%;
		height:750px;
	}
	#leftDownDiv{
		display:inline-block;
		border:1px solid black;
		width:70%;
		height:750px;
	}
	#rightDiv{
		display:inline-block;
		border:1px solid black;
		width:29.5%;
		float:right;
		height:1500px;
	}
	#loginBox{
		margin-top: 50px;
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
	
</style>

<div id="main_Div">

	<div id="leftTopDiv">
	
	</div>
	
	<div id="rightDiv">
		<div id="loginBox">
			<form id="loginForm">
				<span class="loginIpb">아이디</span><input class="form-control" type="text" />
				<span class="loginIpb">비밀번호</span><input class="form-control" type="password" />
				<input type="button" class="btn btn-primary" value="회원가입">
				<input type="button" class="btn btn-primary" value="로그인">
			</form>
		</div>
	</div>
	
	<div id="leftDownDiv">
	
	</div>
</div>
