<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions"  prefix="fn" %>

<jsp:include page="/views/common/header.jsp" />
<style>
	#profiles {width: 100%; height:340px;}
	#pageBar {text-align: center;  position:absolute; bottom:0px; left:50%; }
	#profile-images {width:80%; height:90%; border-spacing:5px; margin:0 auto; overflow:hidden;}
	.profile-img {width:400px; height:305px; object-fit: scale-down; margin:0 auto; overflow:hidden; border-radius:7px;}
	#nicknames {height:10%;}
</style>

<section>
        <aside class="side_nav">
		<div id="searchFilter">
		
		<form action="${ pageContext.request.contextPath }/friends/search" method="post">
			<table>
				<tr>
					<td style="width: 100px">
						<img src="${ path }/resources/images/premium-icon-filter-3171047.png" width="25px">
					</td>
					<th style="text-align:left">필터</th>
				</tr>
				<tr>
					<td>언어</td>
					<td>
						<select name="lang" id="lang" onchange="langFilter(this);">
							<option value="0">-------</option>
							<option value="1">한국어</option>
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
				</tr>
				<%-- 
				<tr>
					<td>성별</td>
					<td width="200px">
						<label><input type="radio" name="gender" value="M" checked>남자</label>
						<label><input type="radio" name="gender" value="F">여자</label>
					</td>
				</tr>
				--%>
				<tr>
					<td>지역</td>
					<td>
						<select name="zone" id="zone" onchange="zoneFilter(this);">
							<option value="19" selected>-------</option>
							<option value="1">서울특별시</option>
							<option value="2">인천광역시</option>
							<option value="3">세종특별시</option>
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
					<td>관심사</td>
					<td>
						<label><input type="checkbox" name="interest" id="interest1" value="운동">운동</label>
						<label><input type="checkbox" name="interest" id="interest2" value="음악">음악</label> <br>
						<label><input type="checkbox" name="interest" id="interest3" value="연예">연예</label>
						<label><input type="checkbox" name="interest" id="interest4" value="미식">미식</label> <br>
						<label><input type="checkbox" name="interest" id="interest5" value="여행">여행</label>
						<label><input type="checkbox" name="interest" id="interest6" value="게임">게임</label> <br>
						<label><input type="checkbox" name="interest" id="interest7" value="독서">독서</label>
						<label><input type="checkbox" name="interest" id="interest8" value="미술">미술</label> <br>
						<label><input type="checkbox" name="interest" id="interest9" value="자기계발">자기계발</label> <br>
						<label><input type="checkbox" name="interest" id="interest10" value="반려동물">반려동물</label>
	
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" id="searchFilterSubmit" value="적용">
					</td>
				</tr>
			</table>
		</form>
		
		</div>
		
		<!-- <div>아이콘 제작자 <a href="https://www.flaticon.com/kr/authors/tempo-doloe" title="Tempo_doloe" style="color: black;" target="_blank">Tempo_doloe</a> from <a href="https://www.flaticon.com/kr/" title="Flaticon" style="color: black;" target="_blank">www.flaticon.com</a></div>  -->
		</aside>
        
    <div id="content">
		<form>
			<label>
				<input type="search" name="friends-search" size="14" style="float:right"> <button type="submit" name="btnFriendsSearch" style="float:right">검색</button>
			</label>
		</form>


		<c:set var="i" value="0" /> 
		<c:set var="j" value="3" />

			<table id="profiles">
			<c:forEach var="member" items="${ list }">
			<c:if test="${i%j == 0 }">
			<tr>
			</c:if>
				<c:if test="${ loginMember.memberNo ne member.memberNo }">
				<th>
				<!-- 프사 클릭시 상세 프로필 화면(=friends/profile.jsp)으로 이동 -->
				<!-- 회원 구분 = memberNo -->
					<div id="profile-images">
						<a href="${ pageContext.request.contextPath }/friends/view?no=${ member.memberNo }">
								<!-- 프로필 사진을 등록하지 않은 경우 -->
								<c:if test="${ empty member.originalFilename }">
								<img class="profile-img" src="${ path }/resources/images/premium-icon-parrot.png" >								
								</c:if>
								
								<!-- 등록된 프로필 사진이 있을 경우 -->
								<c:if test="${ !empty member.originalFilename }">								
								<img class="profile-img" src="${ path }/resources/upload/profile/${ member.originalFilename }">
								</c:if>
						</a>
					</div>
					<div id="nicknames">
						${ member.nickname }
					</div>
				</th>
				</c:if>
				
			<c:if test="${i%j == j-1 }">
			</tr>
			</c:if>
			<c:set var="i" value="${i+1 }" />
			</c:forEach>
			
			<!-- list가 null이거나 비어있을 때 출력 -->
			<c:if test="${ empty list }">
				<tr>
					<th colspan="6"> 
					조회 결과가 없습니다.					
					</th>
				</tr>	
			</c:if>
			
		</table>
			
		
		<div id="pageBar">
			<!-- 맨 처음으로 -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/search?page=1'">&lt;&lt;</button>

			<!-- 이전 페이지로 = getPrevPage() -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/search?page=${ pageInfo.prevPage }'">&lt;</button>

			<!--  10개 페이지 목록 -->
			<!-- 현재(선택된) 페이지는 disabled되도록 -->
			<c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" varStatus="status">
				<c:if test="${ status.current == pageInfo.currentPage }">
					<button disabled>${ status.current }</button>
				</c:if>
				
				<c:if test="${ status.current != pageInfo.currentPage }">
				<button onclick="location.href='${ pageContext.request.contextPath }/friends/search?page=${ status.current }'">${ status.current }</button>
				</c:if>
			</c:forEach>	

			<!-- 다음 페이지로 = getNextPage() -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/search?page=${ pageInfo.nextPage }'">&gt;</button>

			<!-- 맨 끝으로 = getMaxPage()를 통해 얻어올 수 있다. -->
			<button onclick="location.href='${ pageContext.request.contextPath }/friends/search?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
		
		</div>
	</div>
</section>

<jsp:include page="/views/common/footer.jsp" />

