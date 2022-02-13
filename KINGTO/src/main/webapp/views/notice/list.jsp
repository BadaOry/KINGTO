<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/views/common/header.jsp" />
<% request.setCharacterEncoding("UTF-8"); %>		
<style>
	section#notice-content{width:70%; height:100%; margin-left: 10%;}
	div#container{ background-color:rgb(233, 233, 233);}
	div#page-Bar{margin-top:10px; text-align:center; background-color:rgb(243, 176, 70); padding-right: 5px;}
	button#notice-write{margin-left:5%; margin-bottom:20px;}
</style>
<section id="notice-content">
	<h2 align="center">공지사항 </h2>
	<c:if test="${ loginMember.memberRole == '관리자' }">
		<button id="notice-write" onclick="location.href='${ pageContext.request.contextPath }/notice/nwrite'">글쓰기</button>
	</c:if>
	<div id="container">
		<c:if test="${ empty list }">
			<div>
				조회된 게시글이 없습니다.
			</div>
		</c:if>
		<c:if test="${ !empty list }">
			<c:forEach var="notice" items="${ list }">
				<hr>
				<div>
					<div style="float:left; margin-left: 10px">
						<a href="${ pageContext.request.contextPath }/notice/view?no=${ notice.no }">
							공지) ${ notice.title }
						</a>
					</div>
					<div style="text-align: right; margin-right: 10px;"> ${ notice.createdDate } </div>
				</div>
			</c:forEach>
		</c:if>
		<div id="page-Bar">
			<!-- 맨 처음으로 -->
			<button onclick="location.href='${pageContext.request.contextPath}/notice/list?page=1'">&lt;&lt;</button>
			<!-- 이전페이지로 -->
			<button onclick="location.href='${pageContext.request.contextPath}/notice/list?page=${ pageInfo.prevPage }'">&lt;</button>
			
			<!--  10개 페이지 목록 -->
			<c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" varStatus="status">
				<c:if test="${ status.current == pageInfo.currentPage }">
					<button disabled>${ status.current }</button>
				</c:if>
				<c:if test="${ status.current != pageInfo.currentPage }">
					<button onclick="location.href='${pageContext.request.contextPath}/notice/list?page=${ status.current }'">${ status.current }</button>
				</c:if>
			</c:forEach>
			
			<!-- 다음 페이지로 -->
			<button onclick="location.href='${pageContext.request.contextPath}/notice/list?page=${ pageInfo.nextPage }'">&gt;</button>
			<!-- 맨 끝으로 -->
			<button onclick="location.href='${pageContext.request.contextPath}/notice/list?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
		</div>
	
	
	</div>
</section>



	
<jsp:include page="/views/common/footer.jsp" />