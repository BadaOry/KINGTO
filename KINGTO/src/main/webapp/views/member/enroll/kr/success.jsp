<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KINGTO</title>
</head>
<body>
	<div id="success_kr">
		<h2 id="congratulation_kr">환영합니다</h2>
		<pre id="congratulation_kr_text">
회원가입이 완료되었습니다.
			
KINGTO 에서 즐거운 추억을 만들어 보세요 !	
		</pre>
	<div id="success_div">
		<button onclick="location.href='${ path }/'" id="backToMain">메인으로 돌아가기</button>
		<form id="login_page_btn_form" action="${ path }/member/login" method="get">
			<input type="submit" value="로그인" id="login_page_btn_scs">
		</form>
	</div>
</div>
</body>
</html>

<jsp:include page="/views/common/footer.jsp" />