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
<script src="${ path }/resources/js/jquery-3.6.0.js"></script>

</head>
<body>

	<div>
		<h2 align="center"> Join Membership </h2>
		
		<br>
		
		<h4 align="center">User Information</h4>
		
		<form name="memberEnrollFrm" action="${ path }/member/enroll/input_eng" method="post"
					enctype="multipart/form-data">
			<table align="center">
				<tr>
					<th>ID</th>
					<td> <input type="text" name="userId" id="newId" 
								placeholder="4 ~10 characters including alphabet & number" required
								style="width:300px"> 
					</td>
					<td class="checkIdDuplicate"> <input type="button" id="checkIdDuplicate_eng" value="Validate"></td> 
				</tr>
				<tr>
					<th>Password</th>
					<td colspan="2"> <input type="password" name="userPwd" id="pass1" 
										placeholder="5 ~15 characters including alphabet & special symbol & number" required
										style="width:300px">
					</td>
				</tr>
				<tr>
					<th>Check Password</th>
					<td><input type="password" id="pass2" style="width:300px" required></td>
					<td><input type="button" onclick="checkPwd()" value="Check Password"
								style="background-color: rgb(22, 42, 53); color:white; border:white; width:100%; padding-left:10px;">
					</td>
				</tr>
				<tr>
					<th>E-mail</th>
					<td colspan="2"><input type="email" name="userEmail" required style="width:300px"></td>
				</tr>
			</table>
			
			<br><br>
			
			
			<br><br>
			
			<h4 align="center">Learning Information</h4>
			
			<table align="center" >	
				<tr>
					<th>Profile Image</th>
					<td colspan="2" id="profilePreview"></td>
					<td><input type="file" name="upfile"></td>
				</tr>
				<tr>
					<th>Nickname</th>
					<td colspan="2"> <input type="text" name="userNickname" id="newNickname" 
						placeholder="2 ~ 8 characters including Korean&alphabet&number" required
						style="width:320px"> 
					</td>
					<td> <input type="button" id="chekcNicknameDuplicate_eng" value="Validate"></td>
				</tr>
				<tr>
					<th>Nationality</th>
					<td>
							<select id="userNatCode" name="userNatCode" required>
								<optgroup label="Select Nationality" ></optgroup>
								<option value="2">USA</option>
								<option value="3">Japan</option>
								<option value="4">China</option>
								<option value="5">Hongkong</option>
								<option value="6">Vietnam</option>
								<option value="7">India</option>
								<option value="8">Russia</option>
								<option value="9">Turkey</option>
								<option value="10">Canada</option>
								<option value="11">Germany</option>
								<option value="12">England</option>
								<option value="13">France</option>
								<option value="14">Italy</option>
								<option value="15">Spain</option>
							</select>	
					</td>
					<th>Location</th>
					<td>
						<select id="userLocalCode" name="userLocalCode">
							<optgroup label="Select Location" ></optgroup>
							<option value="1">Seoul</option>
							<option value="2">Incheon</option>
							<option value="3">Sejong</option>
							<option value="4">Daejeon</option>
							<option value="5">Daegu</option>
							<option value="6">Gwangju</option>
							<option value="7">Ulsan</option>
							<option value="8">Busan</option>
							<option value="9">Gyeonggi-do</option>
							<option value="10">Gangwon-do</option>
							<option value="11">Chungcheongnam-do</option>
							<option value="12">Chungcheongbuk-do</option>
							<option value="13">Jeollanam-do</option>
							<option value="14">Jeollabuk-do</option>
							<option value="15">Gyeongsangnam-do</option>
							<option value="16">Gyeongsangbuk-do</option>
							<option value="17">Jeju</option>
							<option value="18">etc (Other country)</option>
						</select>	
					</td>
				</tr>
				<tr>
					<th>Mother Tongue</th>
					<td id="lc_one" name="lc_one" colspan="2">
						<select id="lc_one" name="lc_one">
							<option value="2">English</option>
							<option value="3">Japanese</option>
							<option value="4">Chinese</option>
							<option value="5">Cantonese</option>
							<option value="6">Vietnamese</option>
							<option value="7">Hindi</option>
							<option value="8">Russian</option>
							<option value="9">Turkish</option>
							<option value="10">German</option>
							<option value="11">French</option>
							<option value="12">Italian</option>
							<option value="13">Spanish</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>Want to Learn #1</th>
					<td>
						<select id="lc_two" name="lc_two">
							<option value="1">Korean</option>
							<option value="2">English</option>
							<option value="3">Japanese</option>
							<option value="4">Chinese</option>
							<option value="5">Cantonese</option>
							<option value="6">Vietnamese</option>
							<option value="7">Hindi</option>
							<option value="8">Russian</option>
							<option value="9">Turkish</option>
							<option value="10">German</option>
							<option value="11">French</option>
							<option value="12">Italian</option>
							<option value="13">Spanish</option>
						</select>
					</td>
					<th>Language Skill Level</th>
					<td>	
						<select id="lc_two_lv" name="lc_two_lv">
							<option value="1">level 1</option>
							<option value="2">level 2</option>
							<option value="3">level 3</option>
							<option value="4">level 4</option>
							<option value="5">level 5</option>
						</select>					
					</td>
				</tr>
				<tr>
					<th>Want to Learn #2</th>
					<td>
					 		<select id="lc_thr" name="lc_thr">
					 		<option value="1">Korean</option>
							<option value="2">English</option>
							<option value="3">Japanese</option>
							<option value="4">Chinese</option>
							<option value="5">Cantonese</option>
							<option value="6">Vietnamese</option>
							<option value="7">Hindi</option>
							<option value="8">Russian</option>
							<option value="9">Turkish</option>
							<option value="10">German</option>
							<option value="11">French</option>
							<option value="12">Italian</option>
							<option value="13">Spanish</option>
						</select>
					</td>
					<th>Language Skill Level</th>
					<td>	
						<select id="lc_thr_lv" name="lc_thr_lv">
							<option value="1">level 1</option>
							<option value="2">level 2</option>
							<option value="3">level 3</option>
							<option value="4">level 4</option>
							<option value="5">level 5</option>
						</select>					
					</td>
				</tr>
				<tr>
					<th rowspan="3">Interest</th>
					<td>
						<label><input type="checkbox" name="userInt" id="int1" value="Exercise">Exercise</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int2" value="Music/Instrument">Music/Instrument</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int3" value="Kpop/Drama">Kpop/Drama</label>
					</td>
				</tr>
					<tr>
					<td>
						<label><input type="checkbox" name="userInt" id="int4" value="Cuisine">Cuisine</label>
						    
						<label><input type="checkbox" name="userInt" id="int5" value="Travel">Travel</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int6" value="Game">Game</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int7" value="Book">Book</label>	
					</td>
				</tr>
					<tr>
					<td>
						<label><input type="checkbox" name="userInt" id="int8" value="Art/Drawing">Art/Drawing</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int9" value="Self-improvement">Self-improvement</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int10" value="Pet-friendly">Pet-friendly</label>
					</td>
				</tr>
			</table>
			
		
			<br><br>
		
			<table align="center">
				<tr>
					<td>
						<input type="submit" id="enrollSubmit_eng" value="Submit Information">
					</td>
				</tr>
			</table>
		</form>
		
	<br><br><br>
	
	<script>
		// ▼ 아이디 중복 확인 & 조건 검사
		$(document).ready(() => {
			$("#checkIdDuplicate_eng").on("click", () => {
			let userId = $("#newId").val().trim();
			
			// ▼ 아이디 조건 검사
			if(!userId.match(/^[a-z][a-z\d]{3,9}$/)) {
				
				alert("4 ~10 characters including alphabet & number");
				
				return;
			}
			
				$.ajax({
					type: "post",
					url: "${ path }/member/idCheck",
					dataType: "json",
					data: {
						userId
					},
					success: (data) => {
						console.log(data);
						
						if(data.duplicate === true) {
							
							alert("This ID already taken. \nPlease try other ID.");
							$("#newId").val('');
							$("#newId").focus();
						}else {
						
							alert("This ID is available.");
						}
					},
					error: (error) => {
						console.log(error);
					}
				});
			});	
			
		});
		
		// ▼ 닉네임 중복 확인
		$(document).ready(() => {
			$("#chekcNicknameDuplicate_eng").on("click", () => {
			let userNickname = $("#newNickname").val().trim();
			
			// ▼ 닉네임 조건 검사
			if(!userNickname.match(/^[a-z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|\d]{2,8}$/)) {
				
				alert("2 ~ 8 characters including Korean & alphabet & number");
				
				return;
			}
			
				$.ajax({
					type: "post",
					url: "${ path }/member/NicknameCheck",
					dataType: "json",
					data: {
						userNickname
					},
					success: (data) => {
						console.log(data);
						
						if(data.duplicate === true) {
							alert("This Nickname already taken. \nPlease try other Nickname.");
							$("#userNickname").value('');
							$("#userNickname").focus();
						} else {
							
							alert("This nickname is available.");
						}
					},
					error: (error) => {
						console.log(error);
					}
				});
			});
			
			// ▼ Interest Notnull & Submit information check
			$('#enrollSubmit_eng').on('click', function(e){
				
				if($('input[name="userInt"]:checked').length == 0) {
					
					alert('Please select your interest at least one.');

					e.preventDefault()
				}
			});
		});
		
		// ▼ 비밀번호 일치 확인 함수
		function checkPwd() {
			var p1 = document.getElementById('pass1');
			var p2 = document.getElementById('pass2');
			
			// ▼ 비밀번호 조건 확인
			if (!p1.value.match(/^[\w\d!@#$%^&*]{5,15}$/)) {
				alert('5 ~15 characters including alphabet & special symbol & number');
				
                return false;
            }
			
			// ▼ 비밀번호 일치 확인
			if(p1.value != p2.value) {
				alert("Password check error. \nPlease check your password.");
				p2.value = '';
				p2.focus();
				
				return false;
			} else {
				alert("This password is available.");
				
				return true;
			}
			
		}
		
		// ▼ Profile Image Preview
		$(document).ready(() => {
			$('input[name="upfile"]').on('change',function(e) {
				console.log(e);
				
				var reader = new FileReader();
	            reader.onload = function(file){
	            	$('#profilePreview').html($('<img src="'+file.target.result+'">'));
	            };
	            reader.readAsDataURL(e.target.files[0]);
				//$('#profilePreview')
			});
		});
				
	</script>

</body>
</html>
<jsp:include page="/views/common/footer.jsp" />



