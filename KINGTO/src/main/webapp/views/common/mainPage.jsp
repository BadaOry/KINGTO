<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<jsp:include page="/views/common/header.jsp" />

<style>
   #section_height {
      height:1200px;
   }
   
   #mainpage_img {
      text-align:center;
   }
   
   #table_css {
      width:900px;
      height:1000px;
      margin:auto;
      margin-top: 70px;
   }
   
   .content_title {
      height:40px;
      font-size:30px;
      font-weight:bold;
   }
   .content_area {
      width:500px;
      height:300px;
   }
#new-req {width:100%;} 
   
.feed_area {margin:0 auto; border-bottom: solid 1px; }
.feed_img_area>div{height: 200px;width: 200px;}
.feed_img{height: 200px;width: 200px;}
.feed_modify{text-align: right;}
.feed_content>div{width: 250px; height: 150px; font-size: 14px; line-height: 140%; word-break: keep-all; overflow: auto; }

   	.mySgroup_list{display: inline-block; margin: auto;}
	.popular_img{width: 120px; height: 120px; border: 1px solid black;}
   
</style>

<aside class="side_nav" style="height:100%">
	<table id="new-req">
		<tr>
			<th colspan="3">친구 신청</th>
		</tr>
		<tr>
			<td colspan="3" style="width:100%; background-color:rgb(209, 209, 209)"></td>
		</tr>
		
		<c:if test="${ !empty loginMember }">
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
		</c:if>
		
		<c:if test="${ empty loginMember }">
			<tr>
				<td colspan="3" style="text-align:center;"> 
				<a href="${ pageContext.request.contextPath }/member/login" style="text-decoration:none">우선 로그인해주세요.</a>						
				</td>
			</tr>
		</c:if>
	</table>
</aside>


<section id="section_height">
   <table id="table_css">
   
      <tr><!-- 1층 -->
         <td rowspan="6">
            <div style="width:500px; height:1000px;">
               <!-- 킹토 트레이드마크..? -->
               <p id="mainpage_img">
                  <img src="${ path }/resources/images/b42067f35f7d4d2a.png" width="400px";>
               </p>
                  
               <br><br><br><br><br>
            
               <!-- 킹토 설명글 -->
               <p
                  style="font-size: 25px; text-align: center; line-height: 60px;">
                  국내에서 외국어를 배우고 싶은 <u><b>한국인의 <br>
                  니즈</b></u>와 한국에 유학 & 체류하며 한국어를 <br>
                  배우고 싶은 <u><b>외국인의 니즈를 반영</b></u>하여 <br>
                  언어교류 및 친목을 도와주는 <br>
                  <u><b>소셜 디스커버리 웹 사이트</b></u> 입니다
               </p>
            </div>
            </td>
         <td class="content_title"><div>공지</div></td>
      </tr>
         
      <tr><!-- 2층 -->
            <td>
            <div class="content_area">
               <!-- 최신 공지사항 띄우고 온클릭으로 해당 페이지 이동 -->
                  <c:forEach var="notice" items="${ list1 }">
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
            </div>
            </td>
      </tr>
      
      <tr><!-- 3층 -->
         <td class="content_title"><div>피드</div></td>
      </tr>
      
      <tr><!-- 4층 -->
            <td>
            <div class="content_area">
               <!-- 최신 피드 띄우고 온클릭으로 해당 페이지 이동 -->
						<c:forEach var="feed" items="${ list2 }">
							<table class="feed_area">
						    <br>
						    	<tr>
						        	<td colspan="2"><b>${ feed.writerId }</b><br> ${ feed.createDate }</td>
						            <td></td>
						        </tr>
						        <tr>
						        	<th rowspan="3" class="feed_img_area" >
						        	<a href="${ pageContext.request.contextPath }/my_page/recent">
										<c:if test="${!empty feed.renameFileName}">
											<div><img class="feed_img" src="${ path }/resources/upload/feed/${feed.renameFileName}"></div>
										</c:if>
										<c:if test="${empty feed.renameFileName}">
											<div><img class="feed_img" src="${ path }/resources/images/premium-icon-parrot-2071433.png"></div>
										</c:if>
									</a>
						        	</th>
						            	<td rowspan="3" style="width: 20px;"></td>
						                <td class="feed_content">
						                	<div>${ feed.content }</div>
						                </td>
						            </tr>
							</table>
						</c:forEach>
            </div>
            </td>
      
      </tr>
      
      <tr><!-- 5층 -->
         <td class="content_title"><div>인기</div></td>
      </tr>
      
      <tr><!-- 6층 -->
            <td>
            <div class="content_area">
               <c:forEach var="mySgroup" items="${ list3 }">
			    <table class="mySgroup_list">
			    	    <tr>
			                <td rowspan="3">
			                <button type="button" onclick="location.href='${pagecontext.request.contextPath}/group/detail?no=${ mySgroup.sgroup_no }'" >
			                        <c:if test="${!empty mySgroup.sgroup_img}">
						<div><img class="popular_img" src="${ path }/resources/upload/group/${mySgroup.sgroup_img}"></div>
					</c:if>
					<c:if test="${empty mySgroup.sgroup_img}">
						<div><img class="popular_img" src="${ path }/resources/images/premium-icon-parrot-2071433.png"></div>
					</c:if>
			                </button>
			                </td>
			
			                <td>${ mySgroup.sgroup_name }</td>
			            </tr>
			            <tr>
			                <td>[관심사]<br>${ mySgroup.sgroup_interest}</td>
			                <td></td>
			            </tr>
			            <tr>
			                <td>인원수 : ${ mySgroup.sgroup_MemberCount }</td>
			                <td></td>
			            </tr>
			            <tr>
			            	<td colspan="2"><hr></td>
			            </tr>
			    </table>     
			</c:forEach>
            </div>
            </td>
      </tr>
      
   
   </table>
</section>


<jsp:include page="/views/common/footer.jsp" />