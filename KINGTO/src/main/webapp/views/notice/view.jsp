<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    

<jsp:include page="/views/common/header.jsp" />
<style>
	section>div#container{width:70%; margin-left: 10%; auto; background-color: rgb(233,233,233)}
	table#tb-notice{width:1100px; margin:0 auto; border:2px solid gray; border-collapse:collapse; clear:both;}
	table#tb-notice th {border:1px solid; padding: 5px 0; text-align:center;} 
    table#tb-notice td {width: 750px; border:1px solid; padding: 5px 0 5px 10px; text-align:left;}
    td#content{text-align:left; height:500px; nowrap height="500px"}
    div#page_move{padding-bottom:10px; background-color: rgb(243, 176, 70)}
</style>
<section id="notice-content">
	<div id="container">
		<h1>공지사항</h1>
		<hr>
		<div>
			<button onclick="location.href='${ pageContext.request.contextPath }/notice/list'" style="margin-bottom: 10px">목록으로</button>
		<c:if test="${ loginMember.memberRole == '관리자' }">
			<button type="button" id="btnDelete">삭제하기</button>
			<button type="button" id="btnUpdate">수정하기</button>
		</c:if>
		</div>
		<hr>
		<p>${ notice.title }</p>
		<hr>
		 <div>
		 	<div>
		 		<div>조회수 : ${ notice.readCount }</div><div>작성일자 : ${ notice.createdDate }</div>
		 		<hr>
		 	</div>
		 	<p><br></p>
		 	<p><br></p>
		 	<p>${ notice.content }</p>
		 	<p><br></p>
		 	<p><br></p>
		 </div>
		<div id="page_move">
			<hr>
			<ul>
				<li>
					<c:if test="${ notice.prevTitle != '이전글이 없습니다' }">
						<span style="float: left;">이전글</span> <p> <a style="margin-left: 20px;"
								href="${ pageContext.request.contextPath }/notice/view?no=${ notice.prevNo }">${ notice.prevTitle }</a>  </p>
					</c:if>
					<c:if test="${ notice.prevTitle == '이전글이 없습니다' }">
						<span style="float: left;">이전글</span> <p> <a style="margin-left: 20px;"
								href='${ pageContext.request.contextPath }/notice/list'>${ notice.prevTitle }</a>  </p>
					</c:if>
				</li>
				<li>
					<c:if test="${ notice.nextTitle != '다음글이 없습니다' }">
						<span style="float: left;">다음글</span> <p> <a style="margin-left: 20px;"
								href="${ pageContext.request.contextPath }/notice/view?no=${ notice.nextNo }">${ notice.nextTitle }</a>  </p>
					</c:if>
					<c:if test="${ notice.nextTitle == '다음글이 없습니다' }">
						<span style="float: left;">다음글</span> <p> <a style="margin-left: 20px;"
								href='${ pageContext.request.contextPath }/notice/list'>${ notice.nextTitle }</a>  </p>
					</c:if>
				</li>
			</ul>
		</div>
	</div>
</section>
<script>
$(document).ready(() => {
	$("#btnDelete").on("click", () => {
		if(confirm("정말로 게시글을 삭제 하시겠습니까?")) {
			location.replace("${ pageContext.request.contextPath }/notice/delete?no=${ notice.no }");
		}
	});
	
	$("#btnUpdate").on("click", () => {
		if(confirm("정말로 게시글을 수정 하시겠습니까?")) {
			location.replace("${ pageContext.request.contextPath }/notice/update?no=${ notice.no }");
		}
	});
	
});


</script>



<jsp:include page="/views/common/footer.jsp" />