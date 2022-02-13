<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/views/common/header.jsp" />
<Style>
	div#notice-write-container{width:400px; margin:0 auto; text-align:center;}
	div#notice-write-container h2{margin:10px 0;}
	table#tb-notice{width:500px; margin-left:100px; border:1px solid black; border-collapse:collapse;}
	table#tb-notice th{width:125px; border:1px solid; padding:5px 0; text-align:center;}
	table#tb-notice td{border:1px solid; padding:5px 0 5px 10px; text-align:left;}
</Style>
<section id="content">
	<div id='notice-write-container'>
		<h2>게시판 작성</h2>
		<button onclick="location.href='${ pageContext.request.contextPath }/notice/list'" style="margin-bottom: 10px">목록으로</button>
		<form action="${pageContext.request.contextPath}/notice/nwrite" method="POST">
			<table id='tb-notice'>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title"></td>
				</tr>
				<tr>
					<th>작성자번호</th>
					<td><input type="number" name="no"  value="${ loginMember.memberNo }" readonly ></td><!--value="${ loginMember.id }" readonly -->
				</tr>
				<tr>
					<th>내용</th>
					<td><textarea name="content" cols="50" rows="15" ></textarea></td>
				</tr>
				<tr>
					<th colspan="2">
						<input type="submit" value="등록">
						<input type="reset" value="취소">
					</th>
				</tr>
			</table>
		</form>
	</div>
</section>

<jsp:include page="/views/common/footer.jsp" />