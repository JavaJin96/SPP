<%--
  Class Name : EgovIncTopnav.jsp
  Description : 상단메뉴(include)
  Modification Information
 
      수정일         수정자                   수정내용
    -------    --------    ---------------------------
     2011.08.31   JJY       경량환경 버전 생성
 
    author   : 실행환경개발팀 JJY
    since    : 2011.08.31 
--%>
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import ="egovframework.com.cmm.LoginVO" %>

<script type="text/javascript">
</script>

<ul>
	<li><a href="#LINK" onclick="location.href='/SSP/p1/main.do'" >p1</a></li>
    <li><a href="#LINK" onclick="location.href='/SSP/p2/main.do'" >p2</a></li>
    <li><a href="#LINK" onclick="location.href='/SSP/test/main.do'" >test</a></li>
    <li><a href="#LINK" onclick="location.href='/SSP/dc/main.do'" >dc</a></li>
</ul>

<!-- //topmenu end -->