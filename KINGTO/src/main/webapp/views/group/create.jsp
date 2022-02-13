<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/views/common/header.jsp" />

<style>
	.side_nav>ul{list-style: none; margin: 0px; padding: 0px;}
    .side_nav a{ text-align: center; line-height: 45px; font-size: 20px; font-weight: 1000; text-decoration: none; color: black; background-color: white; display: block; height: 50px; border-bottom: rgb(70, 70, 70) solid 1px;}
    .side_nav a:hover{background-color: rgb(224, 224, 224);}
    
    #create_tbl>tr,td{border: 1px solid gray;}
</style>
<section id="group_content">
	<aside class="side_nav">
                <ul>
                    <li><a onclick="location.href='${pagecontext.request.contextPath}/group/list'">내 모임</a></li>
                </ul>
    </aside>
    <h3 align="center">소모임 만들기</h3>
    <form action="${ pageContext.request.contextPath }/group/create" method="post"
				enctype="multipart/form-data">
		<table id="create_tbl">
	        <tr>
	            <td rowspan="5"><img src="" alt=""></td>
	            <td>모임명</td>

	            <td colspan="3"><input type="text" name="sgroup_name"></td>
	            <td><input type="radio" name="sgroup_open" >공개</td>

	        </tr>
	        <tr>
	            <td>친구초대</td>
	            <td><input type="button" value="추가하기"></td>
	        </tr>
	        <tr>
	            <td>모임장</td>
	            <td><input type="text" size="16" value="${ loginMember.nickname }" readonly></td>
	        </tr>
	        <tr>
	            <td rowspan="2">관심사</td>
	            <td><input type="checkbox" name="sgroup_interest" value="운동">운동</td>
	            <td><input type="checkbox" name="sgroup_interest" value="음악/악기">음악/악기</td>
	            <td><input type="checkbox" name="sgroup_interest" value="연예/드라마">연예/드라마</td>
	            <td><input type="checkbox" name="sgroup_interest" value="미식">미식</td>
	            <td><input type="checkbox" name="sgroup_interest" value="여행">여행</td>
	        </tr>
	        <tr>
	            <td><input type="checkbox" name="sgroup_interest" value="게임">게임</td>
	            <td><input type="checkbox" name="sgroup_interest" value="독서">독서</td>
	            <td><input type="checkbox" name="sgroup_interest" value="미술/예술">미술/예술</td>
	            <td><input type="checkbox" name="sgroup_interest" value="자기계발/습관">자기계발/습관</td>
	            <td><input type="checkbox" name="sgroup_interest" value="반려동물">반려동물</td>
	        </tr>
	        <tr>
	            <td><input type="file" name="upfile"></td>
	            <td rowspan="2">모임소개</td>
	            <td rowspan="2" colspan="5"><textarea name="sgroup_introduce" cols="50" rows="3" ></textarea></td>
	        </tr>
	        <tr>
	            <td><input type="submit" value="소모임 만들기"></td>
	        </tr>
	        </tr>
	    </table>
    </form>
</section>
<jsp:include page="/views/common/footer.jsp" />