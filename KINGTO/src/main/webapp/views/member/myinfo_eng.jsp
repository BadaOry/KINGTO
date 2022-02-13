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
		<h2 align="center"> My Information </h2>
		
		<br>
		
		<h4 align="center">User Information</h4>
		
		<form id="memberFrm" action="${ path }/member/update_eng" method="post"
			   enctype="multipart/form-data">
			<table align="center">
				<tr>
					<th>ID</th>
					<td colspan="2"> <p name="userId" id="userId" value="${ loginMember.id }"> ${ loginMember.id } </p></td>

				</tr>
				<tr>
					<th>Password</th>
					<td colspan="2"> <button type="button" id="update_Pwd_eng"
						style="background-color:rgb(22, 42, 53); color:white; border:white; width:100%; padding-left:10px;cursor:pointer;">
						Change Password</button> 
					</td>
				</tr>
				<tr>
					<th>E-mail</th>	
					<td colspan="2"><input type="email" name="userEmail" value=${ loginMember.email }></td>
				</tr>
			</table>
			
			<br><br>
			
			
			<br><br>
			
			<h4 align="center">Learning Information</h4>
			
			<br><br>
			
			<table align="center" id="studyInfo">	
				<tr>
					<th>Profile Image</th>
					<c:if test="${ empty loginMember.originalFilename }">
						<td colspan="2" id="profilePreview">-</td>
					</c:if>
					<c:if test="${ !empty loginMember.originalFilename }">
						<td colspan="2" id="profilePreview"> <img src="${ path }/resources/upload/profile/${ loginMember.originalFilename }"></td>
					</c:if>
					<td><input type="file" name="upfile" id="upfile_btn"></td>
				</tr>
				<tr>
					<th>Nickname</th>
					<td colspan="2"> <input type="text" name="userNickname" id="newNickname" value="${ loginMember.nickname }" placeholder="한글, 영문, 숫자를 포함한 10자리" required> </td>
					<td> <input type="button" id="chekcNicknameDuplicate_eng" value="Validate"></td>
				</tr>
				<tr>
					<th>Nationality</th>
					<td>
						<select id="userNatCode" name="userNatCode">
							<optgroup label="Select Nationality" ></optgroup>
							<option value="2" ${ fn:contains(loginMember.natCode,'2') ? 'selected': ''}>USA</option>
							<option value="3" ${ fn:contains(loginMember.natCode,'3') ? 'selected': ''}>Japan</option>
							<option value="4" ${ fn:contains(loginMember.natCode,'4') ? 'selected': ''}>China</option>
							<option value="5" ${ fn:contains(loginMember.natCode,'5') ? 'selected': ''}>Hongkong</option>
							<option value="6" ${ fn:contains(loginMember.natCode,'6') ? 'selected': ''}>Vietnam</option>
							<option value="7" ${ fn:contains(loginMember.natCode,'7') ? 'selected': ''}>India</option>
							<option value="8" ${ fn:contains(loginMember.natCode,'8') ? 'selected': ''}>Russia</option>
							<option value="9" ${ fn:contains(loginMember.natCode,'9') ? 'selected': ''}>Turkey</option>
							<option value="10" ${ fn:contains(loginMember.natCode,'10') ? 'selected': ''}>Canada</option>
							<option value="11" ${ fn:contains(loginMember.natCode,'11') ? 'selected': ''}>Germany</option>
							<option value="12" ${ fn:contains(loginMember.natCode,'12') ? 'selected': ''}>England</option>
							<option value="13" ${ fn:contains(loginMember.natCode,'13') ? 'selected': ''}>France</option>
							<option value="14" ${ fn:contains(loginMember.natCode,'14') ? 'selected': ''}>Italy</option>
							<option value="15" ${ fn:contains(loginMember.natCode,'15') ? 'selected': ''}>Spain</option>
						</select>
					</td>
					<th>Location</th>
					<td>
						<select id="userLocalCode" name="userLocalCode">
							    <optgroup label="Select Location" ></optgroup>
                                <option value="1" ${ fn:contains(loginMember.localCode,'1') ? 'selected': '' }>Seoul</option>
                                <option value="2" ${ fn:contains(loginMember.localCode,'2') ? 'selected': '' }>Incheon</option>
                                <option value="3" ${ fn:contains(loginMember.localCode,'3') ? 'selected': '' }>Sejong</option>
                                <option value="4" ${ fn:contains(loginMember.localCode,'4') ? 'selected': '' }>Daejeon</option>
                                <option value="5" ${ fn:contains(loginMember.localCode,'5') ? 'selected': '' }>Daegu</option>
                                <option value="6" ${ fn:contains(loginMember.localCode,'6') ? 'selected': '' }>Gwangju</option>
                                <option value="7" ${ fn:contains(loginMember.localCode,'7') ? 'selected': '' }>Ulsan</option>
                                <option value="8" ${ fn:contains(loginMember.localCode,'8') ? 'selected': '' }>Busan</option>
                                <option value="9" ${ fn:contains(loginMember.localCode,'9') ? 'selected': '' }>Gyeonggi-do</option>
                                <option value="10" ${ fn:contains(loginMember.localCode,'10') ? 'selected': '' }>Gangwon-do</option>
                                <option value="11" ${ fn:contains(loginMember.localCode,'11') ? 'selected': '' }>Chungcheongnam-do</option>
                                <option value="12" ${ fn:contains(loginMember.localCode,'12') ? 'selected': '' }>Chungcheongbuk-do</option>
                                <option value="13" ${ fn:contains(loginMember.localCode,'13') ? 'selected': '' }>Jeollanam-do</option>
                                <option value="14" ${ fn:contains(loginMember.localCode,'14') ? 'selected': '' }>Jeollabuk-do</option>
                                <option value="15" ${ fn:contains(loginMember.localCode,'15') ? 'selected': '' }>Gyeongsangnam-do</option>
                                <option value="16" ${ fn:contains(loginMember.localCode,'16') ? 'selected': '' }>Gyeongsangbuk-do</option>
                                <option value="17" ${ fn:contains(loginMember.localCode,'17') ? 'selected': '' }>Jeju</option>
                                <option value="18" ${ fn:contains(loginMember.localCode,'18') ? 'selected': '' }>etc (Other country)</option>
						</select>	
					</td>
				</tr>
				<tr>
					<th>Mother Tongue</th>
					<td id="lc_one" name="lc_one"colspan="2">
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
                               <option value="1" ${ fn:contains(loginMember.lcTwo,'1') ? 'selected': '' }>Korean</option>
                               <option value="2" ${ fn:contains(loginMember.lcTwo,'2') ? 'selected': '' }>English</option>
                               <option value="3" ${ fn:contains(loginMember.lcTwo,'3') ? 'selected': '' }>Japanese</option>
                               <option value="4" ${ fn:contains(loginMember.lcTwo,'4') ? 'selected': '' }>Chinese</option>
                               <option value="5" ${ fn:contains(loginMember.lcTwo,'5') ? 'selected': '' }>Cantonese</option>
                               <option value="6" ${ fn:contains(loginMember.lcTwo,'6') ? 'selected': '' }>Vietnamese</option>
                               <option value="7" ${ fn:contains(loginMember.lcTwo,'7') ? 'selected': '' }>Hindi</optiosn>
                               <option value="8" ${ fn:contains(loginMember.lcTwo,'8') ? 'selected': '' }>Russian</option>
                               <option value="9" ${ fn:contains(loginMember.lcTwo,'9') ? 'selected': '' }>Turkish</option>
                               <option value="10" ${ fn:contains(loginMember.lcTwo,'10') ? 'selected': '' }>German</option>
                               <option value="11" ${ fn:contains(loginMember.lcTwo,'11') ? 'selected': '' }>French</option>
                               <option value="12" ${ fn:contains(loginMember.lcTwo,'12') ? 'selected': '' }>Italian</option>
                               <option value="13" ${ fn:contains(loginMember.lcTwo,'13') ? 'selected': '' }>Spanish</option>
                           </select>
                       </td>
                       <th>Language Skill Level</th>
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
					<th>Want to Learn #2</th>
                    <td>
                    	<select id="lc_thr" name="lc_thr">                         	
                   		  	  <option value="1" ${ fn:contains(loginMember.lcTwo,'1') ? 'selected': '' }>Korean</option>
                              <option value="2" ${ fn:contains(loginMember.lcTwo,'2') ? 'selected': '' }>English</option>
                              <option value="3" ${ fn:contains(loginMember.lcTwo,'3') ? 'selected': '' }>Japanese</option>
                              <option value="4" ${ fn:contains(loginMember.lcTwo,'4') ? 'selected': '' }>Chinese</option>
                              <option value="5" ${ fn:contains(loginMember.lcTwo,'5') ? 'selected': '' }>Cantonese</option>
                              <option value="6" ${ fn:contains(loginMember.lcTwo,'6') ? 'selected': '' }>Vietnamese</option>
                              <option value="7" ${ fn:contains(loginMember.lcTwo,'7') ? 'selected': '' }>Hindi</optiosn>
                              <option value="8" ${ fn:contains(loginMember.lcTwo,'8') ? 'selected': '' }>Russian</option>
                              <option value="9" ${ fn:contains(loginMember.lcTwo,'9') ? 'selected': '' }>Turkish</option>
                              <option value="10" ${ fn:contains(loginMember.lcTwo,'10') ? 'selected': '' }>German</option>
                              <option value="11" ${ fn:contains(loginMember.lcTwo,'11') ? 'selected': '' }>French</option>
                              <option value="12" ${ fn:contains(loginMember.lcTwo,'12') ? 'selected': '' }>Italian</option>
                              <option value="13" ${ fn:contains(loginMember.lcTwo,'13') ? 'selected': '' }>Spanish</option>
                   	 	</select>
                     </td>
                     <th>Language Skill Level</th>
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
                        <th rowspan="4">Interest</th>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int1"
                                value="Exercise" ${ fn:contains(loginMember.interest,'Exercise') ? 'checked': '' }>Exercise</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int2" 
                                value="Music/Instrument" ${ fn:contains(loginMember.interest,'Music/Instrument') ? 'checked': '' }>Music/Instrument</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int3" 
                                value="Kpop/Drama" ${ fn:contains(loginMember.interest,'Kpop/Drama') ? 'checked': '' }>Kpop/Drama</label>
                        </td>
                        
                    </tr>
                        <tr>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int4" 
                                value="Cuisine" ${ fn:contains(loginMember.interest,'Cuisine') ? 'checked': '' }>Cuisine</label>
                                
                            <label><input type="checkbox" name="userInt" id="int5" 
                                value="Travel" ${ fn:contains(loginMember.interest,'여Travel') ? 'checked': '' }>Travel</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int6" 
                                value="Game" ${ fn:contains(loginMember.interest,'Game') ? 'checked': '' }>Game</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int7" 
                                value="Book" ${ fn:contains(loginMember.interest,'Book') ? 'checked': '' }>Book</label>    
                        </td>
                    </tr>
                        <tr>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int8" 
                                value="Art/Drawing" ${ fn:contains(loginMember.interest,'Art/Drawing') ? 'checked': '' }>Art/Drawing</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int9" 
                                value="Self-improvement" ${ fn:contains(loginMember.interest,'Self-improvement') ? 'checked': '' }>Self-improvement</label>
                        </td>
                        <td>
                            <label><input type="checkbox" name="userInt" id="int10" 
								value="Pet-friendly" ${ fn:contains(loginMember.interest,'Pet-friendly') ? 'checked': '' }>Pet-friendly</label>
				</tr>
			</table>
			
		
			<br><br>
		
			<table align="center">
				<tr>
					<td>
						<input type="submit" id="updateSubmit_eng"  value="Change Information">
						<input type="button" id="deleteButton_eng" onClick="location.href='${ path }/member/delete_confirm_eng'" value="Unregister">
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
	        $("#update_Pwd_eng").on("click", () => {
	            const url = "${ path }/member/updatePwd_eng";
	            const status = "left=500px,top=200px,width=800px,height=210px";
	
	            open(url, "", status);
	        });
        });
        
        
		// ▼ 닉네임 중복 확인
		$(document).ready(() => {
			$("#chekcNicknameDuplicate_eng").on("click", () => {
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
			$('#updateSubmit_eng').on('click', function(e){
				
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


