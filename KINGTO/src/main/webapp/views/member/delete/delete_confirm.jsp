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

	<div id="delete_confirm_kr">
		<h2 id="delete_confirm" >회원 탈퇴</h2>
		<pre id="delete_confirm_text">
정말 회원 탈퇴를 하시겠습니까?
		</pre>
	<div id="success_div">
		<button onclick="location.href='${ path }/member/myinfo'" id="backToMyinfo">아니오 (내정보 화면으로)</button>
		<form id="delete_confirm_btn_form" action="${ path }/member/delete" method="post">
			<input type="submit" value="네 (회원 탈퇴)" id="delete_confirm_btn_yes">
		</form>
		
		<!-- 
		<button id="delete_confirm_btn_yes">네 (회원 탈퇴)</button>
		 -->
		
	</div>
</div>

<%-- 
<script>
	$(document).ready(() => {
		// ▼ Open page to delete member info 
		$("#delete_confirm_btn_yes").on("click", () => {
			
				location.replace("${ path }/member/delete");
		});
	});	
		
</script>
--%>




</body>
</html>

<jsp:include page="/views/common/footer.jsp" />