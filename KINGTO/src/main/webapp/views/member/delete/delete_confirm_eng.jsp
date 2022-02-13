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
		<h2 id="delete_confirm" >Unregister</h2>
		<pre id="delete_confirm_text">
Are you sure to unregister our service?
		</pre>
	<div id="success_div">
		<button onclick="location.href='${ path }/member/myinfo_eng'" id="backToMyinfo">No (Back to My Info)</button>
		<form id="delete_confirm_btn_form" action="${ path }/member/delete_eng" method="post">
			<input type="submit" value="Yes (Unregister)" id="delete_confirm_btn_yes_eng">
		</form>

		
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