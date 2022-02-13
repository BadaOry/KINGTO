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
	<div class="select_div">
		<h2 id="select_h2">회원 가입</h2>
		<div id="select_button">
			<button id="kr_button" value="내국인" 
					onclick="location.href='${path}/member/enroll/policy_kr'">내국인</button>
			<button id="fr_button" value="Foreigner"
					onclick="location.href='${path}/member/enroll/policy_eng'">Foreigner</button>
		</div>
	</div>
</body>
</html>

<jsp:include page="/views/common/footer.jsp" />