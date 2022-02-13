<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>       
<jsp:include page="/views/common/header.jsp" />

<style>
	.side_nav>ul{list-style: none; margin: 0px; padding: 0px;}
    .side_nav a{ text-align: center; line-height: 45px; font-size: 20px; font-weight: 1000; text-decoration: none; color: black; background-color: white; display: block; height: 50px; border-bottom: rgb(70, 70, 70) solid 1px;}
    .side_nav a:hover{background-color: rgb(224, 224, 224);}
    
    #group_detail{border: 1px solid black; margin-bottom: 10px}
    #post_sort{margin-bottom: 5px}
    #group_img{width: 120px; height: 120px; border: 1px solid black;}
    .post_img{width: 100px; height: 100px; border: 1px solid black;}
    #pageBar {text-align: center;}
</style>
<section id="group_content">
		 <aside class="side_nav">
                <ul>
                    <li><a onclick="location.href='${pagecontext.request.contextPath}/group/list'">내 모임</a></li>
                </ul>
    	</aside>

    	<div id="content">

		        <table id="group_detail">
		            <tr>
		            	<td rowspan="3">
		            	<c:if test="${ empty GroupList.sgroup_img }">
		            		<img class="post_img" src="${ path }/resources/images/premium-icon-parrot.png" >
		            	</c:if>
		            	
		            	<c:if test="${ !empty GroupList.sgroup_img }">
		                <img id="group_img" src="${ path }/resources/upload/group/${ GroupList.sgroup_img }">
		                </td>
		                </c:if>
		                <th></th>
		                <td></td>
		                <td><button type="button"
		                     onclick="location.href='${ pageContext.request.contextPath }/post/write?no=${ GroupList.sgroup_no }'">글쓰기</button></td>
		            </tr>
		            <tr>
		                <td>${ group.sgroup_open }</td>
		                <td>${ group.sgroup_MemberCount }</td><!-- 인원수 -->
		            </tr>
		            <tr>
		                <td><button type="button">+</button></td>
		                <td>초대</td><!-- ????????????????????????? 크리에이트에서 먼저 구현할것...-->
		            </tr>
		        </table>


        <div id="post_sort">
            게시글
            <button disabled><small>최신순</small></button>
            <button><small>인기순</small></button>
        </div>

        	<c:forEach var="post" items="${ list }">
        <table>
            <tr>
                <td rowspan="3">
                <button type="button">                	
                	<img class="post_img" src="${ path }/resources/images/premium-icon-parrot.png" >
                </button></td>
                <td>${ post.post_no }</td>

                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>좋아요개수</td>
            </tr>
            <tr>
                <td rowspan="3"><button type="button"><img class="post_img" src="" alt=""></button></td>
                <td>게시글1</td>
                <td></td>
            </tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>좋아요개수</td>
            </tr>
            <tr>
                <td rowspan="3"><button type="button"><img class="post_img" src="" alt=""></button></td>
                <td>게시글1</td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td></td>
            </tr>
            <tr>
                <td></td>
                <td>좋아요개수</td>
            </tr>
        </table>    

		</c:forEach>

    <div id="pageBar">
			<!-- 맨 처음으로 -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/detail?page=1'">&lt;&lt;</button>

			<!-- 이전 페이지로 = getPrevPage() -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/detail?page=${ pageInfo.prevPage }'">&lt;</button>

			<!--  10개 페이지 목록 -->
			<c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" varStatus="status">
				<c:if test="${ status.current == pageInfo.currentPage }">				
					<button disabled>${ status.current }</button>
				</c:if>
				
				<c:if test="${ status.current != pageInfo.currentPage }">				
					<button onclick="location.href='${ pageContext.request.contextPath }/group/detail?page=${ status.current }'">${ status.current }</button>
				</c:if>
			</c:forEach>

			<!-- 다음 페이지로 -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/detail?page=${ pageInfo.nextPage }'">&gt;</button>

			<!-- 맨 끝으로 -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/detail?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
		</div>	

	</div>

</section>
<jsp:include page="/views/common/footer.jsp" />