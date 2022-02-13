<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>    
<jsp:include page="/views/common/header.jsp" />
<style>
	#new-req {width:100%;}
	.friend-req-nickname {width: 65%;}
	#profiles {width: 100%; height:340px;} 
	#profile-images {width:80%; height:90%; margin:0 auto; margin-top:5%; overflow:hidden; border-radius: 15px; text-align:center;} 
	.profile-img {width:400px; height:305px; object-fit: scale-down; margin:0 auto; overflow:hidden;}
	#nicknames {height:10%;}
	#pageBar {text-align: center;  position:absolute; bottom:0px; left:50%; }
</style>

<section>
        <aside class="side_nav">
			<table id="new-req">
				<tr>
					<th colspan="3">친구 신청</th>
				</tr>
				<tr>
					<td colspan="3" style="width:100%; background-color:rgb(209, 209, 209)"></td>
				</tr>
				
				<!-- 새로운 친구신청 개수만큼 반복(c:forEach) -->
				<c:if test="${ !empty friendRequests }">
				<c:forEach var="request" items="${ friendRequests }">
				<tr>				
					<td style="width: 65%;">				
					<input type="text" size="16" value="${ request.nickname }" readonly>
					</td>
					<td>
						
						<input type="submit" value="수락" onclick="location.href='${pageContext.request.contextPath}/friend/confirm?no=${ request.memberNo }'"/>
					</td>
					<td>	
						<button onclick="location.href='${pageContext.request.contextPath}/friend/delete?no=${ request.memberNo }'">거절</button>
					</td>
				</tr>
				</c:forEach>
				</c:if>		
				<!-- 새로운 친구신청이 없을 경우 출력, 있으면 숨김 -->
				<c:if test="${ empty friendRequests }">
				<tr>
					<td colspan="3" style="text-align:center;">새로운 친구 신청이 없습니다.</td>
				</tr>
				</c:if>	
			</table>
		</aside>
	
	<div id="content" >
		
		<c:set var="i" value="0" /> 
		<c:set var="j" value="3" />
		
		
		<table id="profiles">
			<c:if test="${ !empty loginMember }">
				<c:forEach var="friends" items="${ list }">
				<c:if test="${i%j == 0 }">
				<tr>
				</c:if>
					<th>
					<!-- 프사 클릭시 상세 프로필 화면(=friends/profile.jsp)으로 이동 -->
					<!-- 회원 구분 = frndConfirm -->
					
					<div id="profile-images">
						<a href="${ pageContext.request.contextPath }/friends/view?no=${ friends.frndTwo }" style="text-decoration:none;">
							<!-- 프로필 사진을 등록하지 않은 경우 -->
							<c:if test="${ empty friends.originalFilename }">
							<img class="profile-img" src="${ path }/resources/images/premium-icon-parrot.png" >								
							</c:if>
							
							<!-- 등록된 프로필 사진이 있을 경우 -->
							<c:if test="${ !empty friends.originalFilename }">								
							<img class="profile-img" src="${ path }/resources/upload/profile/${ friends.originalFilename }">
							</c:if>
						</a>							
						<div id="nicknames">
							${ friends.nickname } 
						</div>
					</div>
					</th>
					
				<c:if test="${i%j == j-1 }">
				</tr>
				</c:if>
				<c:set var="i" value="${i+1 }" />
				</c:forEach>
			
					
			
				<!-- list가 null이거나 비어있을 때 출력 -->
				<c:if test="${ empty list }">
					<tr>
						<th colspan="6"> 
						<a href="${ pageContext.request.contextPath }/friends/search">아직 친구가 없습니다. 친구를 찾아보세요!</a>						
						</th>
					</tr>	
				</c:if>
			</c:if>
			
			<!-- 로그인하지 않았을때 출력 -->
			<c:if test="${ empty loginMember }">
				<tr>
					<th colspan="6"> 
					<a href="${ pageContext.request.contextPath }/member/login" style="text-decoration:none">우선 로그인해주세요.</a>						
					</th>
				</tr>	
			</c:if>
			
		</table>
		
		
		<div id="pageBar">
			<!-- 맨 처음으로 -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/list?page=1'">&lt;&lt;</button>

			<!-- 이전 페이지로 = getPrevPage() -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/list?page=${ pageInfo.prevPage }'">&lt;</button>

			<!--  10개 페이지 목록 -->
			<!-- 현재(선택된) 페이지는 disabled되도록 -->
			<c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" varStatus="status">
				<c:if test="${ status.current == pageInfo.currentPage }">
					<button disabled>${ status.current }</button>
				</c:if>
				
				<c:if test="${ status.current != pageInfo.currentPage }">
				<button onclick="location.href='${ pageContext.request.contextPath }/friends/list?page=${ status.current }'">${ status.current }</button>
				</c:if>
			</c:forEach>
			

			<!-- 다음 페이지로 = getNextPage() -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/list?page=${ pageInfo.nextPage }'">&gt;</button>

			<!-- 맨 끝으로 = getMaxPage()를 통해 얻어올 수 있다. -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/list?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
		</div>
	
	</div>
</section>

<jsp:include page="/views/common/footer.jsp" />
