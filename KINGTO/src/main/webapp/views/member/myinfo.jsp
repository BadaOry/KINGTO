<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

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
		<h2 align="center"> 내 정보 </h2>
		
		<br>
		
		<h4 align="center">회원 정보</h4>
		
		<form id="memberFrm" action="${ path }/member/update" method="post"
			   enctype="multipart/form-data">
			<table align="center">
				<tr>
					<th>아이디</th>
					<td colspan="2"> <p name="userId" id="userId" value="${ loginMember.id }"> ${ loginMember.id } </p></td>

				</tr>
				<tr>
					<th>비밀번호</th>
					<td colspan="2"> <button type="button" id="update_Pwd"
						style="background-color: rgb(243, 176, 70); border:white; width:100%; padding-left:10px;cursor:pointer;">비밀번호 변경</button> 
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					
					<td colspan="2"><input type="email" name="userEmail" value=${ loginMember.email }></td>
				</tr>
			</table>
			
			<br><br>
			
			
			<br><br>
			
			<h4 align="center">학습 정보</h4>
			
			<br><br>
			
			<table align="center" id="studyInfo">	
				<tr>
					<th>프로필 사진</th>
					<c:if test="${ empty loginMember.originalFilename }">
						<td colspan="2" id="profilePreview">-</td>
					</c:if>
					<c:if test="${ !empty loginMember.originalFilename }">
						<td colspan="2" id="profilePreview"> <img src="${ path }/resources/upload/profile/${ loginMember.originalFilename }"></td>
					</c:if>
					<td><input type="file" name="upfile" id="upfile_btn"></td>
				</tr>
				<tr>
					<th>닉네임</th>
					<td colspan="2"> <input type="text" name="userNickname" id="newNickname" value="${ loginMember.nickname }" placeholder="한글, 영문, 숫자를 포함한 10자리" required> </td>
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
                                <option value="1" ${ fn:contains(loginMember.localCode,'1') ? 'selected': '' }>서울특별시</option>
                                <option value="2" ${ fn:contains(loginMember.localCode,'2') ? 'selected': '' }>인천광역시</option>
                                <option value="3" ${ fn:contains(loginMember.localCode,'3') ? 'selected': '' }>세종특별자치시</option>
                                <option value="4" ${ fn:contains(loginMember.localCode,'4') ? 'selected': '' }>대전광역시</option>
                                <option value="5" ${ fn:contains(loginMember.localCode,'5') ? 'selected': '' }>대구광역시</option>
                                <option value="6" ${ fn:contains(loginMember.localCode,'6') ? 'selected': '' }>광주광역시</option>
                                <option value="7" ${ fn:contains(loginMember.localCode,'7') ? 'selected': '' }>울산광역시</option>
                                <option value="8" ${ fn:contains(loginMember.localCode,'8') ? 'selected': '' }>부산광역시</option>
                                <option value="9" ${ fn:contains(loginMember.localCode,'9') ? 'selected': '' }>경기도</option>
                                <option value="10" ${ fn:contains(loginMember.localCode,'10') ? 'selected': '' }>강원도</option>
                                <option value="11" ${ fn:contains(loginMember.localCode,'11') ? 'selected': '' }>충청남도</option>
                                <option value="12" ${ fn:contains(loginMember.localCode,'12') ? 'selected': '' }>충청북도</option>
                                <option value="13" ${ fn:contains(loginMember.localCode,'13') ? 'selected': '' }>전라남도</option>
                                <option value="14" ${ fn:contains(loginMember.localCode,'14') ? 'selected': '' }>전라북도</option>
                                <option value="15" ${ fn:contains(loginMember.localCode,'15') ? 'selected': '' }>경상남도</option>
                                <option value="16" ${ fn:contains(loginMember.localCode,'16') ? 'selected': '' }>경상북도</option>
                                <option value="17" ${ fn:contains(loginMember.localCode,'17') ? 'selected': '' }>제주도</option>
                                <option value="18" ${ fn:contains(loginMember.localCode,'18') ? 'selected': '' }>기타(국외)</option>
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
                               <option value="2" ${ fn:contains(loginMember.lcTwo,'2') ? 'selected': '' }>영어</option>
                               <option value="3" ${ fn:contains(loginMember.lcTwo,'3') ? 'selected': '' }>일본어</option>
                               <option value="4" ${ fn:contains(loginMember.lcTwo,'4') ? 'selected': '' }>중국어</option>
                               <option value="5" ${ fn:contains(loginMember.lcTwo,'5') ? 'selected': '' }>홍콩어</option>
                               <option value="6" ${ fn:contains(loginMember.lcTwo,'6') ? 'selected': '' }>베트남어</option>
                               <option value="7" ${ fn:contains(loginMember.lcTwo,'7') ? 'selected': '' }>힌디어</optiosn>
                               <option value="8" ${ fn:contains(loginMember.lcTwo,'8') ? 'selected': '' }>러시아어</option>
                               <option value="9" ${ fn:contains(loginMember.lcTwo,'9') ? 'selected': '' }>터키어</option>
                               <option value="10" ${ fn:contains(loginMember.lcTwo,'10') ? 'selected': '' }>독일어</option>
                               <option value="11" ${ fn:contains(loginMember.lcTwo,'11') ? 'selected': '' }>프랑스어</option>
                               <option value="12" ${ fn:contains(loginMember.lcTwo,'12') ? 'selected': '' }>이탈리아어</option>
                               <option value="13" ${ fn:contains(loginMember.lcTwo,'13') ? 'selected': '' }>스페인어</option>
                           </select>
                       </td>
                       <th>외국어 능력</th>
                       <td>    
                           <select id="lc_two_lv" name="lc_two_lv">
                               <option value="1" ${ fn:contains(loginMember.lcTwoLv,'1') ? 'selected': '' }>level 1</option>
                               <option value="2" ${ fn:contains(loginMember.lcTwoLv,'2') ? 'selected': '' }>level 2</option>
                               <option value="3" ${ fn:contains(loginMember.lcTwoLv,'3') ? 'selected': '' }>level 3</option>
                               <option value="4" ${ fn:contains(loginMember.lcTwoLv,'4') ? 'selected': '' }>level 4</option>
                               <option value="5" ${ fn:contains(loginMember.lcTwoLv,'5') ? 'selected': '' }>level 5</option>
						</select>					
					</td>
				</tr>
				<tr>
					<th>배우고싶은 외국어 #2</th>
                    <td>
                         <select id="lc_thr" name="lc_thr">
	                         <option value="2" ${ fn:contains(loginMember.lcThr,'2') ? 'selected': '' }>영어</option>
	                         <option value="3" ${ fn:contains(loginMember.lcThr,'3') ? 'selected': '' }>일본어</option>
	                         <option value="4" ${ fn:contains(loginMember.lcThr,'4') ? 'selected': '' }>중국어</option>
	                         <option value="5" ${ fn:contains(loginMember.lcThr,'5') ? 'selected': '' }>홍콩어</option>
	                         <option value="6" ${ fn:contains(loginMember.lcThr,'6') ? 'selected': '' }>베트남어</option>
	                         <option value="7" ${ fn:contains(loginMember.lcThr,'7') ? 'selected': '' }>힌디어</option>
	                         <option value="8" ${ fn:contains(loginMember.lcThr,'8') ? 'selected': '' }>러시아어</option>
	                         <option value="9" ${ fn:contains(loginMember.lcThr,'9') ? 'selected': '' }>터키어</option>
	                         <option value="10" ${ fn:contains(loginMember.lcThr,'10') ? 'selected': '' }>독일어</option>
	                         <option value="11" ${ fn:contains(loginMember.lcThr,'11') ? 'selected': '' }>프랑스어</option>
	                         <option value="12" ${ fn:contains(loginMember.lcThr,'12') ? 'selected': '' }>이탈리아어</option>
	                         <option value="13" ${ fn:contains(loginMember.lcThr,'13') ? 'selected': '' }>스페인어</option>
                         </select>
                     </td>
                     <th>외국어 능력</th>
                     <td>    
                         <select id="lc_thr_lv" name="lc_thr_lv">
                             <option value="1" ${ fn:contains(loginMember.lcThrLv,'1') ? 'selected': '' }>level 1</option>
                             <option value="2" ${ fn:contains(loginMember.lcThrLv,'2') ? 'selected': '' }>level 2</option>
                             <option value="3" ${ fn:contains(loginMember.lcThrLv,'3') ? 'selected': '' }>level 3</option>
                             <option value="4" ${ fn:contains(loginMember.lcThrLv,'4') ? 'selected': '' }>level 4</option>
                             <option value="5" ${ fn:contains(loginMember.lcThrLv,'5') ? 'selected': '' }>level 5</option>
                         </select>                    					
					</td>
				</tr>
				                    <tr>
                        <th rowspan="4">관심사</th>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int1"
                                value="운동" ${ fn:contains(loginMember.interest,'운동') ? 'checked': '' }>운동</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int2" 
                                value="음악/악기" ${ fn:contains(loginMember.interest,'음악/악기') ? 'checked': '' }>음악/악기</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int3" 
                                value="연예/드라마" ${ fn:contains(loginMember.interest,'연예/드라마') ? 'checked': '' }>연예/드라마</label>
                        </td>
                        
                    </tr>
                        <tr>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int4" 
                                value="미식" ${ fn:contains(loginMember.interest,'미식') ? 'checked': '' }>미식</label>
                                
                            <label><input type="checkbox" name="userInt" id="int5" 
                                value="여행" ${ fn:contains(loginMember.interest,'여행') ? 'checked': '' }>여행</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int6" 
                                value="게임" ${ fn:contains(loginMember.interest,'게임') ? 'checked': '' }>게임</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int7" 
                                value="독서" ${ fn:contains(loginMember.interest,'독서') ? 'checked': '' }>독서</label>    
                        </td>
                    </tr>
                        <tr>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int8" 
                                value="미술/예술" ${ fn:contains(loginMember.interest,'미술/예술') ? 'checked': '' }>미술/예술</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int9" 
                                value="자기계발/습관" ${ fn:contains(loginMember.interest,'자기계발/습관') ? 'checked': '' }>자기계발/습관</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int10" 
								value="반려동물" ${ fn:contains(loginMember.interest,'반려동물') ? 'checked': '' }>반려동물</label>
				</tr>
			</table>
			
		
			<br><br>
		
			<table align="center">
				<tr>
					<td>
						<input type="submit" id="updateSubmit"  value="정보 수정">
						<input type="button" id="deleteButton" onClick="location.href='${ path }/member/delete_confirm'" value="회원 탈퇴">
					</td>
				</tr>
			</table>
			
			<input type="hidden" name="userNo" value="${ loginMember.memberNo }">
			<input type="hidden" name="userId" value="${ loginMember.id }">
			<input type="hidden" name="userPwd" value="${ loginMember.pwd }">
			
		</form>
		
	<br><br><br>
	
	
	<script>	
		// ▼ 비밀번호 수정 페이지 오픈
	    $(document).ready(() => {
	        $("#update_Pwd").on("click", () => {
	            const url = "${ path }/member/updatePwd";
	            const status = "left=500px,top=200px,width=800px,height=210px";
	
	            open(url, "", status);
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
			$('#updateSubmit').on('click', function(e){
				
				if($('input[name="userInt"]:checked').length == 0) {
					
					alert('관심사를 한 개 이상 선택해주세요.');

					e.preventDefault()
				}
			});
		});
		
		
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

