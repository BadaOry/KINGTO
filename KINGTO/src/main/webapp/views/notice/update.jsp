<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:include page="/views/common/header.jsp" />
<Style>
	div#notice-update-container{width:400px; margin:0 auto; text-align:center;}
	div#notice-update-container h2{margin:10px 0;}
	table#tb-notice{width:500px; margin-left:100px; border:1px solid black; border-collapse:collapse;}
	table#tb-notice th{width:125px; border:1px solid; padding:5px 0; text-align:center;}
	table#tb-notice td{border:1px solid; padding:5px 0 5px 10px; text-align:left;}
</Style>
<section id="content">
	<div id='notice-update-container'>
		<h1 style="text-align: center;">게시판 수정</h1>
		<form action="${pageContext.request.contextPath}/notice/update" method="POST" >
			<input type="hidden" name="no" value="${ notice.no }">
			<table id='tb-notice'>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title"
							value="${ notice.title }"></td>
				</tr>
				<tr>
					<th>작성자</th>
					<td><input type="text" name="writer" value="${ notice.writerId }" readonly></td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea name="content" cols="50" rows="15" >${ notice.content }</textarea>
					</td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="수정">
						<input type="button" onclick="location.replace('${pageContext.request.contextPath}/notice/list')" value="목록으로">
					</th>
				</tr>
			</table>
		</form>
	</div>
</section>
<jsp:include page="/views/common/footer.jsp" />