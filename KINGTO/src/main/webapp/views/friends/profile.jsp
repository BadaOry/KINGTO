<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<jsp:include page="/views/common/header.jsp" />

<style>
	.profile {height : 100%; width:60%; margin:0 auto;}
	#profile-frame {width:50%; height:60%; margin-top:15%; float: left; border-radius: 15px; background-color:rgb(243, 243, 243);}
	#profile-img {width:90%; height:90%; object-position: 50% 50%; margin:0 auto; margin-top:5%; border-radius: 15px; text-align:center;}
	.profile-img {width:90%; height:90%; object-fit: contain; border-radius: 15px; overflow:hidden;}
	#profile-area {width:50%; height:60%; margin-top:15%; float: left; border-radius: 15px;}
	#profile-content {width:100%; height:100%;}	
</style>

<section>
           
	<div class="profile">
		<div id="profile-frame">
			<div id="profile-img">
				<!-- 프로필 사진을 등록하지 않은 경우 -->
				<c:if test="${ empty member.originalFilename }">
				<img class="profile-img" src="${ path }/resources/images/premium-icon-parrot.png" >								
				</c:if>
				
				<!-- 등록된 프로필 사진이 있을 경우 -->
				<c:if test="${ !empty member.originalFilename }">								
				<img class="profile-img" src="${ path }/resources/upload/profile/${ member.originalFilename }">
				</c:if>
			</div>
		</div>
	
		<div id="profile-area">
			<table id="profile-content">
				<thead style="display: none;">
					<tr>
						<td>
							<form action="${ pageContext.request.contextPath }/friend/request" method="POST">
							
							<input type="text" name="frndTwo" value="${ member.memberNo }" readonly>
							</form>
						</td>
					</tr>
				</thead>
				<tr>
				
					<th>닉네임</th>
					<td>${ member.nickname }</td>				
				</tr>
				<tr>
					<th>국적</th>
					<td>${ member.natName }</td>
				</tr>
				<tr>
					<th>모국어</th>
					<td>${ member.langName }</td>			
				</tr>
				
				<tr>
					<th>배우고 싶은 언어</th>
					<td>${ lcTwo }</td>			
				</tr>
				
				<tr>
					<th>관심사</th>
					<td>${ member.interest }</td>
				</tr>
				
				<tr>
					<th>
						<button type="button" onclick="location.href='${ referer }'">목록으로</button>
					</th>
					
					<!-- 로그인하지 않으면 친구 버튼은 보이지 않음 -->
					<c:if test="${ !empty loginMember }">
					<th>					
						<!-- 이미 친구면 '친구 삭제' 버튼 활성화 -->
						<!-- FriendCheckServlet 거쳐서 isFriend가 false -->
						
							<c:if test="${ isFriend }">
							<button type="button" onclick="location.href='${ pageContext.request.contextPath }/friend/delete?no=${ member.memberNo }'" 
									id="btnDelete">
							친구 삭제
							</button>						
							</c:if>
						
						<!-- 친구가 아니면 '친구 추가; 버튼 활성화 -->
							<c:if test="${ !isFriend }">
							<button type="button" onclick="location.href='${ pageContext.request.contextPath }/friend/request?no=${ member.memberNo }'"
									id="btnAdd">
							친구 추가
							</button>
							</c:if>
						
					</th>
					</c:if>
					
					<th>
						<button type="button" onclick="location.href='${ pageContext.request.contextPath }/friend/feed?no=${ member.memberNo }'"
								id="btnFeed">피드 보기</button>
					</th>
				</tr>
			</table>
		</div>
	</div> 
	
</section>

<jsp:include page="/views/common/footer.jsp" />

