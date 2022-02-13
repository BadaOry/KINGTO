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
		<h2 id="congratulation_kr">정상적으로 탈퇴되었습니다.</h2>
		<pre id="congratulation_kr_text">
KINGTO 서비스를 이용해주셔서 감사합니다.
KINGTO 에서의 즐거운 추억과 함께 다시 한번 방문해주세요.
		</pre>
	<div id="success_div">
		<button onclick="location.href='${ path }'" id="backToMain">메인으로 돌아가기</button>

	</div>
</div>

</body>
</html>

<jsp:include page="/views/common/footer.jsp" />