<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/views/common/header.jsp" />

<style>

	.side_nav>ul{list-style: none; margin: 0px; padding: 0px;}
    .side_nav a{ text-align: center; line-height: 45px; font-size: 20px; font-weight: 1000; text-decoration: none; color: black; background-color: white; display: block; height: 50px; border-bottom: rgb(70, 70, 70) solid 1px;}
    .side_nav a:hover{background-color: rgb(224, 224, 224);}
    
    .popular_title{font-size: 20px}
   	.popular_list{display: inline-block; margin: 20px;}
    /* #popular_list>tr,td,th{border: 1px solid black;} */
    .popular_img{width: 120px; height: 120px; border: 1px solid black;}
    #content_area{text-align: center;}
    #group_pageBar {text-align: center;}
</style>
<section id="group_content">
	<aside class="side_nav">
                <ul>
                    <li><a onclick="location.href='${pagecontext.request.contextPath}/group/list'">내 모임</a></li>
                </ul>
    </aside>
    
    <div id="content">
    <div id="content_area">
        <table class="popular_list">
            <tr>
                <th colspan="2" class="popular_title">인기있는 소모임</th>
                <th></th>
            </tr>
            
        <c:forEach var="popularlist" items="${ Popularlist }">
            <tr>
                <td rowspan="3">
                	<button type="button" onclick="location.href='${pagecontext.request.contextPath}/group/detail?no=${ popularlist.sgroup_no }'" >

                		<c:if test="${!empty popularlist.sgroup_img}">
							<div><img class="popular_img" src="${ path }/resources/upload/group/${popularlist.sgroup_img}"></div>
						</c:if>
						<c:if test="${empty popularlist.sgroup_img}">
							<div><img class="popular_img" src="${ path }/resources/images/premium-icon-parrot-2071433.png"></div>
						</c:if>
                	</button>
                </td>
                <td>${ popularlist.sgroup_name }</td>
            </tr>
            <tr>
                <td>[관심사]<br>${ popularlist.sgroup_interest}</td>

                <td></td>
            </tr>
            <tr>
                <td>인원수 : ${ popularlist.sgroup_MemberCount }</td>
                <td></td>
            </tr>

            <tr>
            	<td colspan="2"><hr></td>
            </tr>
        </c:forEach> 

        </table>
        
        <table class="popular_list">
            <tr>
                <th colspan="2" class="popular_title">최신 소모임</th>
                <th></th>
            </tr>
            
        <c:forEach var="recectlist" items="${ RecectList }">
            <tr>
                <td rowspan="3">
                <button type="button" onclick="location.href='${pagecontext.request.contextPath}/group/detail?no=${ recectlist.sgroup_no}'" >
                	    <c:if test="${!empty recectlist.sgroup_img}">
							<div><img class="popular_img" src="${ path }/resources/upload/group/${recectlist.sgroup_img}"></div>
						</c:if>
						<c:if test="${empty recectlist.sgroup_img}">
							<div><img class="popular_img" src="${ path }/resources/images/premium-icon-parrot-2071433.png"></div>
						</c:if>
                </button>
                </td>
                <td>${ recectlist.sgroup_name }</td>
            </tr>
            <tr>
                <td>[관심사]<br>${ recectlist.sgroup_interest}</td>
                <td></td>
            </tr>
            <tr>
                <td>인원수 : ${ recectlist.sgroup_MemberCount }</td>
            </tr>
            <tr>
            	<td colspan="2"><hr></td>
            </tr>
        </c:forEach> 

        </table>
	
		<!--페이지 리스트 구성-->
        <div id="group_pageBar">
	        <!-- 맨 처음으로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/group/main?page=1'">&lt;&lt;</button>
	        
	        <!-- 이전 페이지로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/group/main?page=${ PopularpageInfo.prevPage }'">&lt;</button>
	          
	        <!--  페이지 목록 -->
	        <c:forEach  begin="${ PopularpageInfo.startPage }" end="${ PopularpageInfo.endPage }" varStatus="status">
	       		<c:if test="${ status.current == PopularpageInfo.currentPage }">
	        	<button disabled >${ status.current }</button>
	        	</c:if>
	                        	
	        	<c:if test="${ status.current != PopularpageInfo.currentPage }">
	        	<button onclick="location.href='${ pagecontext.request.contestPath }/group/main?page=${ status.current }'">${ status.current }</button>
	        	</c:if>
	        </c:forEach>
	                        
	        <!-- 다음 페이지로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/group/main?page=${ PopularpageInfo.nextPage }'">&gt;</button>
	            
	        <!-- 맨 끝으로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/group/main?page=${ PopularpageInfo.maxPage }'">&gt;&gt;</button>
    	</div>	
    	</div>
	</div>
</section>
<jsp:include page="/views/common/footer.jsp" />

