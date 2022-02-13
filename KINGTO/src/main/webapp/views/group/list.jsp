<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
    
<jsp:include page="/views/common/header.jsp" />

<style>
	.side_nav>ul{list-style: none; margin: 0px; padding: 0px;}
    .side_nav a{ text-align: center; line-height: 45px; font-size: 20px; font-weight: 1000; text-decoration: none; color: black; background-color: white; display: block; height: 50px; border-bottom: rgb(70, 70, 70) solid 1px;}
    .side_nav a:hover{background-color: rgb(224, 224, 224);}
	
	.mySgroup_list{display: inline-block; margin: 20px; }

	.popular_img{width: 120px; height: 120px; border: 1px solid black;}
    #group_find{margin-top: 8px; margin-bottom: 5px; margin-left: 270px;}
    #img_pile{margin: auto; width: 800px; height: 88%; margin-bottom: 20px;  text-align:center;}

    #new_btn{float: right; margin-right: 130px}
    #group_pageBar {text-align: center;}
</style>

<section id="group_content">

	 <aside class="side_nav">
                <ul>
                    <li><a onclick="location.href='${pagecontext.request.contextPath}/group/list'">�� ����</a></li>
                </ul>
    </aside>
    <div id="content">
    
	<div id="group_find">
        <input type="text" placeholder="�Ҹ��� ã��">
        <button>�˻�</button>
        <button id="new_btn" type="button" onclick="location.href='${pagecontext.request.contextPath}/group/create'">�� ����</button>
        <!-- <c:if test="${ !empty loginMember }"> �α��� �� �� ����--> 
        <!-- </c:if> -->
    </div>
    
    <c:if test="${ empty list }">
    		��ȸ�� ������ �����ϴ�.
    </c:if>

    <c:if test="${ !empty list }">
    
    <div id="img_pile">   
    <c:forEach var="mySgroup" items="${ list }">
    <table class="mySgroup_list">
    	    <tr>
                <td rowspan="3">
                <button type="button" onclick="location.href='${pagecontext.request.contextPath}/group/detail?no=${ mySgroup.sgroup_no }'" >
                        <c:if test="${!empty mySgroup.sgroup_img}">
							<div><img class="popular_img" src="${ path }/resources/upload/group/${mySgroup.sgroup_img}"></div>
						</c:if>
						<c:if test="${empty mySgroup.sgroup_img}">
							<div><img class="popular_img" src="${ path }/resources/images/premium-icon-parrot.png"></div>
						</c:if>
                </button>
                </td>

                <td>${ mySgroup.sgroup_name }</td>
            </tr>
            <tr>
                <td>[���ɻ�]<br>${ mySgroup.sgroup_interest}</td>
                <td></td>
            </tr>
            <tr>
                <td>�ο��� : ${ mySgroup.sgroup_MemberCount }</td>
                <td></td>
            </tr>
            <tr>
            	<td colspan="2"><hr></td>
            </tr>
    </table>     
    </c:forEach>
    
    
    
    
    </div>

    </c:if>
    
    <div id="group_pageBar">
			<!-- �� ó������ -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/list?page=1'">&lt;&lt;</button>

			<!-- ���� �������� -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/list?page=${ pageInfo.prevPage }'">&lt;</button>

			<!--  10�� ������ ��� -->
			<c:forEach begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }" varStatus="status">
				<c:if test="${ status.current == pageInfo.currentPage }">				
					<button disabled>${ status.current }</button>
				</c:if>
				
				<c:if test="${ status.current != pageInfo.currentPage }">				
					<button onclick="location.href='${ pageContext.request.contextPath }/group/list?page=${ status.current }'">${ status.current }</button>
				</c:if>
			</c:forEach>

			<!-- ���� �������� -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/list?page=${ pageInfo.nextPage }'">&gt;</button>

			<!-- �� ������ -->
			<button onclick="location.href='${ pageContext.request.contextPath }/group/list?page=${ pageInfo.maxPage }'">&gt;&gt;</button>
		</div>	

	</div>
</section>


<jsp:include page="/views/common/footer.jsp" />