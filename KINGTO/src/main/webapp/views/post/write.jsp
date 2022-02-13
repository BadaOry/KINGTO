<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/views/common/header.jsp" />

<style>
	.side_nav>ul{list-style: none; margin: 0px; padding: 0px;}
    .side_nav a{ text-align: center; line-height: 45px; font-size: 20px; font-weight: 1000; text-decoration: none; color: black; background-color: white; display: block; height: 50px; border-bottom: rgb(70, 70, 70) solid 1px;}
    .side_nav a:hover{background-color: rgb(224, 224, 224);}
	div#board-write-container
	{
		width:600px;
		margin:0 auto;
		text-align:center;
	}
	
	div#board-write-container h2
	{
		margin:10px 0;
	}
	
	table#tbl-board
	{
		width:500px;
		margin:0 auto;
		border:1px solid black;
		border-collapse:collapse;
	}
	
	table#tbl-board th
	{
		width:125px;
		border:1px solid;
		padding:5px 0;
		text-align:center;
	}
	
	table#tbl-board td
	{
		border:1px solid;
		padding:5px 0 5px 10px;
		text-align:left;
	}
</style>
<section id="content">
	<aside class="side_nav">
                <ul>
                    <li><a onclick="location.href='${pagecontext.request.contextPath}/group/list'">내 모임</a></li>
                </ul>
    </aside>
	<div id='board-write-container'>
		<h3>게시글 작성</h3>
		<form action="${ pageContext.request.contextPath }/post/write" method="post">
			<table id='tbl-board'>
				<tr>
					<th>제목</th>
					<td><input type="text" name="title" id="title"></td>
				</tr>
			<!-- 	
				<tr>
					<th>작성자</th>
					<td><input type="text" name="writer" value="${ loginMember.id }" readonly></td>
				</tr> 
			-->
			<!--<tr>
					<th>첨부파일</th>
					<td><input type="file" name="upfile"></td>
				</tr>  -->
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