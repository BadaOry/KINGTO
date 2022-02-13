<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<c:set var="path" value="${ pageContext.request.contextPath }"/>

<jsp:include page="/views/common/header.jsp" />

<section id="report_table">
	<h2 align="center">신고 관리</h2>
	
	<table align="center" border="1">
		<tr>
			<th>신고 번호</th>
			<th>신고 시간</th>
			<th style="width:200px">신고자 아이디</th>
			<th style="width:200px">피신고자 아이디</th> 
			<th styel="200px">신고 피드 번호</th>
			<th style="width:600px">신고 내용</th>
		</tr>
			
			


			<tr>
				<td align=center>10</td>
				<td align=center>2021/12/19 21:07</td>
				<td align=center>test10</td>
				<td align=center>bad10</td>
				<td align=center>361</td>
				<td align=center>광고</td>
			</tr>
			<tr>
				<td align=center>9</td>
				<td align=center>2021/12/19 09:23</td>
				<td align=center>test9</td>
				<td align=center>bad9</td>
				<td align=center>271</td>
				<td align=center>음란 광고</td>
			</tr>			
			<tr>
				<td align=center>8</td>
				<td align=center>2021/12/18 19:57</td>
				<td align=center>test8</td>
				<td align=center>bad8</td>
				<td align=center>246</td>
				<td align=center>광고</td>
			</tr>
			<tr>
				<td align=center>7</td>
				<td align=center>2021/12/18 11:32</td>
				<td align=center>test7</td>
				<td align=center>bad7</td>
				<td align=center>211</td>
				<td align=center>욕설 및 도배</td>
			</tr>
			<tr>
				<td align=center>6</td>
				<td align=center>2021/12/17 00:42</td>
				<td align=center>test6</td>
				<td align=center>bad6</td>
				<td align=center>170</td>
				<td align=center>광고</td>
			</tr>
			<tr>
				<td align=center>5</td>
				<td align=center>2021/12/16 12:16</td>
				<td align=center>test5</td>
				<td align=center>bad5</td>
				<td align=center>76</td>
				<td align=center>허위 사실 유포</td>
			</tr>
			<tr>
				<td align=center>4</td>
				<td align=center>2021/12/16 07:33</td>
				<td align=center>test4</td>
				<td align=center>bad4</td>
				<td align=center>126</td>
				<td align=center>음란 광고</td>
			</tr>
			<tr>
				<td align=center>3</td>
				<td align=center>2021/12/16 03:56</td>
				<td align=center>test3</td>
				<td align=center>bad3</td>
				<td align=center>34</td>
				<td align=center>도박 및 사행성</td>
			</tr>
			<tr>
				<td align=center>2</td>
				<td align=center>2021/12/15 19:03</td>
				<td align=center>test2</td>
				<td align=center>bad2</td>
				<td align=center>15</td>
				<td align=center>광고</td>
			</tr>
			<tr>
				<td align=center>1</td>
				<td align=center>2021/12/15 14:21</td>
				<td align=center>test1</td>
				<td align=center>bad1</td>
				<td align=center>98</td>
				<td align=center>도박 및 사행성</td>
			</tr>
	</table>
		<%-- 
			<tr>
				<c:forEach var="report" items="${ list }">
					<td id="report_no">${ report.reportNo }</td>
					<td id="report_date">${ report.reportDate }</td>
					<td id="reporter_member_no">${ member.memberNo }</td> <!-- <td>${ report.memberNo }</td>  -->
					<td id="reporter_member_no">${ member.memberNo }</td> <!-- <td>${ report.memberNo }</td>  -->
					<td id="report_content">${ report.reportContent }</td>	
				</c:forEach>
			</tr>
		--%>
	

	<br><br>


		<div id="page-Bar" align="center">
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
					<button onclick="location.href='${path}/notice/list?page=${ status.current }'">${ status.current }</button>
				</c:if>
			</c:forEach>
			
			<!-- 다음 페이지로 -->
			<button onclick="location.href='${path}/notice/list?page=${ pageInfo.nextPage }'">&gt;</button>
			<!-- 맨 끝으로 -->
			<button onclick="location.href='${path}/notice/list?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
		</div>
		
	</table>
	
</section>

<jsp:include page="/views/common/footer.jsp" />