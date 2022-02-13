<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<jsp:include page="/views/common/header.jsp" />
<style>
	/*화면 구성에 필요한 스타일*/
	section{width: 100%; height: calc(100vh - 180px); }
	aside{width: 15%; height : 100%; background-color: rgb(243, 243, 243); float: left;}
	#content{width: 85%; height : 100%; overflow: scroll; float: left;}

	/*좌측 매뉴 스타일*/
	.side_nav>ul{list-style: none; margin: 0px; padding: 0px;}
	.side_nav a{ text-align: center; line-height: 45px; font-size: 20px; font-weight: 1000; text-decoration: none; color: black; background-color: white; display: block; height: 50px; border-bottom: rgb(70, 70, 70) solid 1px;}
	.side_nav a:hover{background-color: rgb(224, 224, 224);}

	/*피드 작성 스타일*/
	.feed_write_area {margin:0 auto; border-bottom: solid 1px; }

	/*이미지 스타일*/
	.feed_img{height: 300px;width: 300px;object-fit: scale-down;}
       
</style>
    
    
    
<section>
	<!--좌측 매뉴바 구성-->
	<aside class="side_nav">
		<ul>
			<li><a onclick="location.href='${pagecontext.request.contestPath}/my_page/recent?page=1'">최신피드</a></li>
			<li><a onclick="location.href='${pagecontext.request.contestPath}/my_page/myFeed'" style="background-color: rgb(220, 220, 220);">내 피드</a></li>
			<li><a onclick="location.href='${pagecontext.request.contestPath}/my_page/recommended?page=1'">추천피드</a></li>
			<li><a onclick="location.href='${ path }/member/myinfo'">프로필수정</a></li>
		</ul>
	</aside>
    <!--컨텐츠 구성-->
	<div id="content" >
		<form action="${pagecontext.request.contestPath}/my_page/feed_updata" method="POST" enctype="multipart/form-data" >	
			<input type="hidden" name="no" value="${ feed.no }">
			<input type="hidden" name="originalFileName" value="${ feed.originalFileName }">
			<input type="hidden" name="renameFileName" value="${ feed.renameFileName }">
			<br><br>
            <table class="feed_write_area"> 
				<tr>
                	<td colspan="3" >
                    	${ feed.writerId } <br> <input type="hidden" name="wirterId" value="${ feed.writerId }">
                    </td>
                </tr>
                <tr>
                	<th rowspan="3" >
	                	<c:if test="${!empty feed.renameFileName}">
	                    	<div><img id="preview-image" class="feed_img" src="${ path }/resources/upload/feed/${feed.renameFileName}"></div>
	                	</c:if>
	               		<c:if test="${empty feed.renameFileName}">
	                    	<div><img id="preview-image" class="feed_img" src="${ path }/resources/images/premium-icon-parrot-2071433.png"></div>
	                	</c:if>    
                    </th>
                    <td rowspan="3" style="width: 20px;"></td>
                    <td>
                    	<h3>이미지 첨부</h3>
                       	<input type="file" id="input_image" name="input_image" >
                    </td>
                </tr>
                <tr>
                	<td>
                    	<h3>내용</h3>
                        <textarea name="content" cols="55" rows="7" style="resize: none" >${ feed.content }</textarea>
                    </td>
                </tr>
                <tr>
                	<td>
                    	<div id="text_count" style="text-align: right;">(0 / 100)</div>
                        <input type="submit" value="등록">
						<input type="button" onclick="history.back()" value="취소">
						<input type="button" id="feed_delete" value="삭제">
                    </td>
                </tr>
            </table>
        </form>
    </div>
</section>
        
<script>

	let btn3 = document.getElementById('feed_delete');

	btn3.addEventListener('click', (event) => {
		if(confirm("정말로 게시글을 삭제 하시겠습니까?")){
			location.replace("${pagecontext.request.contestPath}/my_page/feed_delete?no=${feed.no}&wirterId=${feed.writerId}");
		}
	});
		
	<!--이미지 미리보기-->
	function readImage(input) {
	
	// 인풋 태그에 파일이 있는 경우
	if(input.files && input.files[0]) {
	
	    // 이미지 파일인지 검사 (생략)
	
	    // FileReader 인스턴스 생성
	    const reader = new FileReader()
	
	    // 이미지가 로드가 된 경우
	    reader.onload = e => {
	        const previewImage = document.getElementById("preview-image")
	        previewImage.src = e.target.result
	    }
	
	    // reader가 이미지 읽도록 하기
	    reader.readAsDataURL(input.files[0])
	}
	};
		
	// input file에 change 이벤트 부여
	const inputImage = document.getElementById("input_image")
	inputImage.addEventListener("change", e => {
	readImage(e.target)
	});
	
</script>
        
<jsp:include page="/views/common/footer.jsp" />