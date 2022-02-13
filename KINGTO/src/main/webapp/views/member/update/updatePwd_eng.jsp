<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<c:set var="path" value="${ pageContext.request.contextPath }"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KINGTO</title>
<style>
    div#updatePassword-container{
        background:white;
    }
    div#updatePassword-container-top{
        background:rgb(22, 42, 53);
        height:20px;
    }
    div#updatePassword-container-bottom{
        background:rgb(22, 42, 53);
        height:20px;
    }
    div#updatePassword-container table {
        margin:0 auto;
        border-spacing: 20px;
    }
    div#updatePassword-container table tr:last-of-type td {
        text-align:center;
    }
    
    
</style>
<script src="${ path }/resources/js/jquery-3.6.0.js"></script>
</head>
<body>
	<div id="updatePassword-container-top">
	</div>
	
	<div id="updatePassword-container">
		<form action="${ path }/member/updatePwd_eng" method="post">
			<table>
				<tr>
					<th>New Password</th>
					<td>
						<input type="password" name="userPwd" id="pass1" 
						placeholder="5 ~15 characters including alphabet & special symbol & number" required
						style="width:400px">
					</td>
				</tr>
				<tr>
					<th>Check Password</th>
					<td>
						<input type="password" id="pass2" style="width:400px">
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<input type="submit" value="Change" id="change" onclick="return validate();"
							style="background-color: rgb(22, 42, 53);color:white;border:white;">
						&nbsp;
						<input type="button" value="Close" onclick="self.close();"
							style="background-color:rgb(209, 209, 209);border:white;">
					</td>
				</tr>
			</table>
			<input	type="hidden" name="userId">	
		</form>
	</div>
	
	<div id="updatePassword-container-bottom">
	</div>
	<script>
	
	$(document).ready(() =>{
		
		$('#change').on('click', function(e){
			var p1 = document.getElementById('pass1');
			var p2 = document.getElementById('pass2');
			
			if (!p1.value.match(/^[\w\d!@#$%^&*]{5,15}$/)) {
				alert('5 ~15 characters including alphabet & special symbol & number');
				p1.value = '';
				p1.focus();
				
				e.preventDefault();
				
				return false;
	        }
			
			// ▼ 비밀번호 일치 확인
			if(p1.value != p2.value) {
				alert("Password check error. \nPlease check your password.");
				p2.value = '';
				p2.focus();
				
				e.preventDefault();
				
				return;
				
			} else {
				alert("This password is available.");
				
				return true;
			}
		});
		
	});
	</script>




</body>
</html>
