<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />
<style>
	#friend-content {height: 600px;}
	section>article {float: left; height: 100%;}
	#content1 {width: 15%;}
	#content2 {width: 80%;}
	#searchFilter {height: 90%;}
	#profiles {width: 100%; height: 90%;}
	#pageBar {text-align: center;}
	#nicknames {height:10%;}
</style>

<section id="member-login-content">
	
	<br><br><br>
	
	<h2 align="center">로그인</h2>
	
	<br>
	
	<form action="${ path }/member/login" method="post">

		<table align="center">

			<tr>
				<th>아이디</th>
				<td>
					<input type="text" name="userId" id="userId" placeholder="아이디" 
							value="${ empty cookie.saveId ? '' : cookie.saveId.value }" required>
				</td>

				<td rowspan="2"><input type="submit" value="로그인"
					style="	background-color:rgb(243, 176, 70); width:100%; height:50px; border:white; cursor: pointer;"></td>
			</tr>
			<tr>
				<th>비밀번호</th>
				<td><input type="password" name="userPwd" id="userPwd" placeholder="비밀번호" required></td>
			</tr>
			<tr>

				<td colspan="3" style="text-align:right">
					<label ><input type="checkbox" name="saveId" ${ empty cookie.saveId ? "" : "checked" }>아이디 저장</label>
				</td>
			</tr>
		
		</table>
	
	</form>

</section>



<jsp:include page="/views/common/footer.jsp" />