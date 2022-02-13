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
		<h2 align="center"> 회원 가입 </h2>
		
		<br>
		
		<h4 align="center">회원 정보</h4>
		

		<form name="memberEnrollFrm" action="${ path }/member/enroll/input_kr" method="post"
					enctype="multipart/form-data">
			<table align="center">
				<tr>
					<th>아이디</th>
					<td> <input type="text" name="userId" id="newId" placeholder="영문, 숫자를 포함한 4~10자리" required
								style="width:240px"> </td>
					<td class="checkIdDuplicate"> <input type="button" id="checkIdDuplicate" value="중복검사"></td> 
				</tr>
				<tr>
					<th>비밀번호</th>
					<td colspan="2"> <input type="password" name="userPwd" id="pass1" placeholder="영문, 숫자, 특수기호를 포함한 5 ~15자리" required
											style="width:240px" > </td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" id="pass2" style="width:240px" required></td>
					<td><input type="button" onclick="checkPwd()" value="비밀번호 확인"
								style="background-color: rgb(243, 176, 70); border:white; width:100%; padding-left:10px;">
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td colspan="2"><input type="email" name="userEmail" required style="width:240px"></td>
				</tr>
			</table>
			
			<br><br>
			
			<br><br>
			
			<h4 align="center">학습 정보</h4>
			
			<table align="center" >	
				<tr>
					<th>프로필 사진</th>
					<td colspan="2" id="profilePreview"></td>
					<td><input type="file" name="upfile"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td colspan="2"> <input type="text" name="userNickname" id="newNickname" placeholder="한글, 영문, 숫자를 포함한 2~8자리" required
											style="width:240px"> </td>
					<td> <input type="button" id="chekcNicknameDuplicate" value="중복 확인"></td>
				</tr>
				<tr>
					<th>국적</th>
					<td>대한민국</td>
					<!--  name="userNatCode" value="1" -->
					<th>지역</th>
					<td>
						<select id="userLocalCode" name="userLocalCode">
							<optgroup label="지역선택" ></optgroup>
							<option value="1">서울특별시</option>
							<option value="2">인천광역시</option>
							<option value="3">세종특별자치시</option>
							<option value="4">대전광역시</option>
							<option value="5">대구광역시</option>
							<option value="6">광주광역시</option>
							<option value="7">울산광역시</option>
							<option value="8">부산광역시</option>
							<option value="9">경기도</option>
							<option value="10">강원도</option>
							<option value="11">충청남도</option>
							<option value="12">충청북도</option>
							<option value="13">전라남도</option>
							<option value="14">전라북도</option>
							<option value="15">경상남도</option>
							<option value="16">경상북도</option>
							<option value="17">제주도</option>
							<option value="18">기타(국외)</option>
						</select>	
					</td>
				</tr>
				<tr>
					<th>모국어</th>
					<td id="lc_one" name="lc_one"colspan="2">한국어</td>
				</tr>
				<tr>
					<th>배우고싶은 외국어 #1</th>
					<td>
						<select id="lc_two" name="lc_two">
							<option value="2">영어</option>
							<option value="3">일본어</option>
							<option value="4">중국어</option>
							<option value="5">홍콩어</option>
							<option value="6">베트남어</option>
							<option value="7">힌디어</option>
							<option value="8">러시아어</option>
							<option value="9">터키어</option>
							<option value="10">독일어</option>
							<option value="11">프랑스어</option>
							<option value="12">이탈리아어</option>
							<option value="13">스페인어</option>
						</select>
					</td>
					<th>외국어 능력</th>
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
					<th>배우고싶은 외국어 #2</th>
					<td>
					 		<select id="lc_thr" name="lc_thr">
							<option value="2">영어</option>
							<option value="3">일본어</option>
							<option value="4">중국어</option>
							<option value="5">홍콩어</option>
							<option value="6">베트남어</option>
							<option value="7">힌디어</option>
							<option value="8">러시아어</option>
							<option value="9">터키어</option>
							<option value="10">독일어</option>
							<option value="11">프랑스어</option>
							<option value="12">이탈리아어</option>
							<option value="13">스페인어</option>
						</select>
					</td>
					<th>외국어 능력</th>
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
					<th rowspan="3">관심사</th>
					<td>
						<label><input type="checkbox" name="userInt" id="int1" value="운동">운동</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int2" value="음악/악기">음악/악기</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int3" value="연예/드라마">연예/드라마</label>
					</td>
				</tr>
					<tr>
					<td>
						<label><input type="checkbox" name="userInt" id="int4" value="미식">미식</label>
						    
						<label><input type="checkbox" name="userInt" id="int5" value="여행">여행</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int6" value="게임">게임</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int7" value="독서">독서</label>	
					</td>
				</tr>
					<tr>
					<td>
						<label><input type="checkbox" name="userInt" id="int8" value="미술/예술">미술/예술</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int9" value="자기계발/습관">자기계발/습관</label>
					</td>
					<td>
						<label><input type="checkbox" name="userInt" id="int10" value="반려동물">반려동물</label>
					</td>
				</tr>
			</table>
			
		
			<br><br>
		
			<table align="center">
				<tr>
					<td>
						<input type="submit" id="enrollSubmit" value="회원 가입 완료">
					</td>
				</tr>
			</table>
		</form>
		
	<br><br><br>
	
	<script>
		// ▼ 아이디 중복 확인 & 조건 검사
		$(document).ready(() => {
			$("#checkIdDuplicate").on("click", () => {
			let userId = $("#newId").val().trim();
			
			// ▼ 아이디 조건 검사
			if(!userId.match(/^[a-z][a-z\d]{3,9}$/)) {
				
				alert("영문, 숫자를 포함한 4~10자리 아이디를 입력해주세요.");
				
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
							alert("이미 사용중인 아이디 입니다. 다른 아이디를 입력해주세요.");
							$("#newId").val('');
							$("#newId").focus();
						}else {
						
							alert("사용 가능한 아이디 입니다.");
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
			$("#chekcNicknameDuplicate").on("click", () => {
			let userNickname = $("#newNickname").val().trim();
			
			// ▼ 닉네임 조건 검사
			if(!userNickname.match(/^[a-z|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|\d]{2,8}$/)) {
				
				alert("한글, 영문, 숫자를 포함한 2~8자리 닉네임을 입력해주세요.");
				
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
							alert("이미 사용중인 닉네임 입니다. 다른 닉네임을 입력해주세요.");
							$("#userNickname").value('');
							$("#userNickname").focus();
						} else {
							
							alert("사용 가능한 닉네임 입니다.");
						}
					},
					error: (error) => {
						console.log(error);
					}
				});
			});

			// ▼ Interest Notnull & Submit information check
			$('#enrollSubmit').on('click', function(e){
				
				if($('input[name="userInt"]:checked').length == 0) {
					
					alert('관심사를 한 개 이상 선택해주세요.');

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
				alert('영문, 숫자, 특수기호를 포함한 5 ~15자리 비밀번호를 입력해주세요.');
				
                return false;
            }
			
			// ▼ 비밀번호 일치 확인
			if(p1.value != p2.value) {
				alert("비밀번호가 일치하지 않습니다. 다시 입력해주세요.");
				p2.value = '';
				p2.focus();
				
				return false;
			} else {
				alert("비밀번호가 일치합니다.");
				
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



