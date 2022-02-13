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
		<h2 id="congratulation_kr">Welcome !</h2>
		<pre id="congratulation_kr_text">
You successfully joined out service.

Let's find out new friend and get a precious memory at KINGTO!
		
		</pre>
	<div id="success_div">
		<button onclick="location.href='${ path }/'" id="backToMain">Go Back to Main Page</button>
		<form id="login_page_btn_form" action="${ path }/member/login" method="get">
			<input type="submit" value="Login" id="login_page_btn_scs">
		</form>
	</div>
</div>

</body>
</html>

<jsp:include page="/views/common/footer.jsp" />