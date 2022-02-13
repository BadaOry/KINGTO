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
        background:rgb(243, 176, 70);
        height:20px;
    }
    div#updatePassword-container-bottom{
        background:rgb(243, 176, 70);
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
		<form action="${ path }/member/updatePwd" method="post">
			<table>
				<tr>
					<th>변경할 비밀번호</th>
					<td>
						<input type="password" name="userPwd" id="pass1" 
						placeholder="영문, 숫자, 특수기호를 포함한 5 ~15자리 비밀번호를 입력해주세요." required
						style="width:300px;">
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td>
						<input type="password" id="pass2" style="width:300px;">
					</td>
				</tr>

				<tr>
					<td colspan="2">
						<input type="submit" value="변경" onclick="return validate();"
							style="background-color:rgb(243, 176, 70);border:white;">
						&nbsp;
						<input type="button" value="닫기" onclick="self.close();"
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
				alert('영문, 숫자, 특수기호를 포함한 5 ~15자리 비밀번호를 입력해주세요.');
				p1.value = '';
				p1.focus();
				
				e.preventDefault();
				
				return false;
	        }
			
			// ▼ 비밀번호 일치 확인
			if(p1.value != p2.value) {
				alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				p2.value = '';
				p2.focus();
				
				e.preventDefault();
				
				return;
				
			} else {
				alert("비밀번호가 일치합니다.");
				
				return true;
			}
		});
		
	});
		function validate() {
			let pass1 = $("#pass1").val();
			let pass2 = $("#pass2").val();
			
			if(pass1.trim() != pass2.trim()){
				alert("비밀번호가 일치하지 않습니다.");
				$("#pass1").val("");
				$("#pass2").val("");
				$("#pass1").focus();
				
				return false;
			}
		}
	</script>




</body>
</html>
