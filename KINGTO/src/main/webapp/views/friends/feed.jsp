<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/views/common/header.jsp" />

    <style>
		/*화면 구성에 필요한 스타일*/
        section{width: 100%; height: calc(100vh - 180px); }
        aside{width: 15%; height : 100%; background-color: rgb(243, 243, 243); float: left;}
        #content{width: 85%; height : 100%; overflow: scroll; float: left;}
		#feed_write {text-align: center; background-color:  rgb(22, 42, 53); color: white; height: 100px; line-height: 100px;}
		
		/*좌측 매뉴 스타일*/
        .side_nav>ul{list-style: none; margin: 0px; padding: 0px;}
        .side_nav a{ text-align: center; line-height: 45px; font-size: 20px; font-weight: 1000; text-decoration: none; color: black; background-color: white; display: block; height: 50px; border-bottom: rgb(70, 70, 70) solid 1px;}
        .side_nav a:hover{background-color: rgb(224, 224, 224);}
		
		/*피드 스타일*/
        .feed_recent_area {margin:0 auto; border-bottom: solid 1px; }
        .feed_modify{text-align: right;}
        .feed_img{height: 300px;width: 300px;object-fit: scale-down;}
        .feed_content>div{width: 400px; height: 100px; font-size: 14px; line-height: 140%; word-break: keep-all; overflow: auto; }
        .feed_replys_area>div{width: 400px; height: 200px; overflow: auto;}
		
		/*댓글 스타일*/
        .tbl-comment{width:380px; margin:0 auto; border-collapse:collapse; clear:both; } 
        .tbl-comment tr td{border-bottom:1px solid; padding:5px; text-align:left; line-height:120%;}
        .tbl-comment tr td:first-of-type{padding: 5px 5px 5px 50px;}
        .tbl-comment tr td:last-of-type {text-align:right; width: 100px;}
        .tbl-comment button.btn-delete{display:none;}
        .tbl-comment tr:hover {background:lightgray;}
        .tbl-comment tr:hover button.btn-delete{display:inline;}
        .tbl-comment sub.comment-writer {color:navy; font-size:14px}
        .tbl-comment sub.comment-date {color:tomato; font-size:10px}
		
		/*댓글 등록 스타일*/
        .comment-container button.btn-insert{width:60px;height:50px; color:white; background-color:#162a35;position:relative;top:-20px;}

		/*페이지 리스트 스타일*/
        #pageBar{margin-top:10px; text-align:center}
        
        #new-req {width:100%;}
    </style>



<section>
	<!--좌측 매뉴바 구성-->
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
    
    <!--컨텐츠 구성-->
    <div id="content" >
    	<br>
    	
    	<%-- 
    	<a onclick="location.href='${pagecontext.request.contestPath}/friend/feed_write'">
        	<div id="feed_write" ><h1>새 피드 작성</h1></div>
		</a>
            	
			<!--비 로그인시 화면 구성-->
            <c:if test="${ empty list}">
				<table class="feed_recent_area">
					<tr><th>조회된글이 없습니다.</th></tr> 
				</table>
			</c:if>
				
			<!--로그인시 화면 구성-->
			<c:if test="${ !empty list}">
    	--%>

            	
            	<!--피드 구성-->
				<c:forEach var="feed" items="${ list }">
	            	<table class="feed_recent_area">
	                	<br><br>
	                	<tr>
	                    	<td colspan="2"><b>${ feed.writerId }</b><br> ${ feed.createDate } </td>
	                        <td class="feed_modify">
			                	<button onclick="location.href='${pagecontext.request.contestPath}/my_page/feed_updata?no=${ feed.no }'">수정/삭제</button>
	                        </td>
	                    </tr>
		                <tr>
	                    	<th rowspan="3">
	                        	<c:if test="${!empty feed.renameFileName}">
	                           		<div><img class="feed_img" src="${ path }/resources/upload/feed/${feed.renameFileName}"></div>
	                            </c:if>
	                            <c:if test="${empty feed.renameFileName}">
	                           		<div><img class="feed_img" src="${ path }/resources/images/premium-icon-parrot-2071433.png"></div>
	                            </c:if>  
	                        </th>
	                        <td rowspan="3" style="width: 20px;"></td>
	                        <td class="feed_content">
	                        	<div>${ feed.content }</div>
	                        </td>
	                    </tr>
		                <tr>
		                
		                	<!--댓글 구성-->
	                    	<td class="feed_replys_area">
	                        	<div>
	                            	<c:forEach var="replies" items="${ feed.replies }">
			                        	<table class="tbl-comment">
			                            	<tr class="level1">
			                                	<td>
			                                    	<sub class="comment-writer"> ${replies.writer_id} </sub>
			                                        <sub class="comment-date"> ${replies.createDate} </sub>
			                                        <br>
			                                        ${replies.content}
			                                    </td>
			                                    <td>
			                                    	<c:if test="${ ! empty loginMember && loginMember.id eq replies.writer_id }">
			                                        	<form action="${pagecontext.request.contestPath}/my_page/replies_delete" method="GET">
	                                       					<input type="hidden" name="currentPage" value="/myFeed?page=${ pageInfo.currentPage }">
	                                       			    	<input type="hidden" name="no" value="${replies.no}">
	                                       			    	<input type="hidden" name="writer_id" value="${replies.writer_id}">
	                                          	        	<button class="btn-delete" type="submit">삭제</button>
	                                       	            </form>
	                                       	        </c:if>
			                                    </td>
			                                </tr>
			                            </table>
	                                </c:forEach>
	                            </div>
	                        </td>
	                        
	                    </tr>
	                 	<tr>
	                    	<td>
	                    	
	                    		<!--댓글 등록 구성-->
	                        	<div class="comment-container">
	                            	<div class="comment-editor">
	                                	<form action="${pagecontext.request.contestPath}/replies" method="POST">
	                                    	<input type="hidden" name="currentPage" value="/myFeed?page=${ pageInfo.currentPage }">
	                                        <input type="hidden" name="feedNo" value="${ feed.no }">
	                                        <textarea name="feed_replies_content" cols="45" rows="3" style="resize: none;" ></textarea>
	                                        <button type="submit" class="btn-insert">등록</button>	    			
	                                    </form>
	                                </div>
	                            </div>
	                            
	                        </td>
	                    </tr>
	               	</table>
	            </c:forEach>
			<%--
			 </c:if>
			 --%>
			
		<!--페이지 리스트 구성-->
        <div id="pageBar">
	        <!-- 맨 처음으로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/my_page/myFeed?page=1'">&lt;&lt;</button>
	        
	        <!-- 이전 페이지로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/my_page/myFeed?page=${ pageInfo.prevPage }'">&lt;</button>
	          
	        <!--  페이지 목록 -->
	        <c:forEach  begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" varStatus="status">
	       		<c:if test="${ status.current == pageInfo.currentPage }">
	        	<button disabled >${ status.current }</button>
	        	</c:if>
	                        	
	        	<c:if test="${ status.current != pageInfo.currentPage }">
	        	<button onclick="location.href='${ pagecontext.request.contestPath }/my_page/myFeed?page=${ status.current }'">${ status.current }</button>
	        	</c:if>
	        </c:forEach>
	                        
	        <!-- 다음 페이지로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/my_page/myFeed?page=${ pageInfo.nextPage }'">&gt;</button>
	            
	        <!-- 맨 끝으로 -->
	        <button onclick="location.href='${ pagecontext.request.contestPath }/my_page/myFeed?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
    	</div>
    	
	</div>

</section>

<jsp:include page="/views/common/footer.jsp" />