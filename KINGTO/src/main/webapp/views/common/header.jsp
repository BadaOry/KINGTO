<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="path" value="${ pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>KINGTO</title>

<script src="${ path }/resources/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="${ path }/resources/css/style.css">

</head>
<body>
	<div id="warp">

        <header>
                <div id="header1" >
                    <h1>
                    	<a href="${ path }/" style="color:#f3b046; text-decoration:none">
	                        <img id="logo" src="${ path }/resources/images/premium-icon-parrot-2071433.png">
	                        <b id="title">KINGTO</b>
                        </a>
                    </h1>
                </div>
                
               	<div id="header3" >
                	<c:if test="${ empty loginMember }">
	                	<table>
	                		<tr>
		                		<td>
									<input type="button" id="enroll_btn" value="회원가입"
			                			onclick="location.href = '${ path }/member/enroll/select';">
		                		</td>
		                		<td>│</td>
		                		<form id="login_page_btn" action="${ path }/member/login" method="get">
			                		<td><input type="submit" value="로그인"></td>
		                		</form>
	                		</tr>
	                	</table>
                	</c:if>
                	<c:if test="${ !empty loginMember && loginMember.memberRole == '내국인'}">
                		<table>
                			<tr>
				   				<td colspan="2">
				   					${ loginMember.nickname } 님 환영합니다.
				   				</td>
                			</tr>
                			<tr>
                				<td>
									<button onclick="location.href='${ path }/member/myinfo'">내 정보</button>
								</td>
								<td>
									<button onclick="location.replace('${ path }/logout')">로그아웃</button>
								</td>
                			</tr>
                			
                		</table>
                	</c:if>
                	<c:if test="${ !empty loginMember && loginMember.memberRole == '외국인' }">
                		<table>
                			<tr>
				   				<td colspan="2">
				   					Welcome ${ loginMember.nickname } .
				   				</td>
                			</tr>
                			<tr>
                				<td>
									<button onclick="location.href='${ path }/member/myinfo_eng'">My Info</button>
								</td>
								<td>
									<button onclick="location.replace('${ path }/logout')">Logout</button>
								</td>
                			</tr>
                		</table>
                	</c:if>
                	<c:if test="${ !empty loginMember && loginMember.memberRole == '관리자'}">
                        <table>
                            <tr>
                                   <td colspan="2">
                                       홈페이지 관리자 ${ loginMember.nickname } 님 환영합니다.
                                   </td>
                            </tr>
                            <tr>
                                <td>
                                    <button onclick="location.href='${ path }/member/myinfo'">내 정보</button>
                                </td>
                                <td>
                                    <button onclick="location.replace('${ path }/logout')">로그아웃</button>
                                </td>
                            </tr>

                        </table>
                    </c:if>
                </div>
                

                <nav class="header_nav">
                    <ul >
                        <li><a href="${ path }/notice/list">공지사항</a>
                            <ul>
                                <c:if test="${ !empty loginMember && loginMember.memberRole == '관리자'}">
                                <li><a href="${ path }/admin/report_board">관리자 페이지</a></li>
                                </c:if>
                            </ul>
                        </li>
        
                        <li><a href="${ path }/friends/list">친구찾기</a>
                            <ul>
                                <li><a href="${ path }/friends/list">친구 목록</a></li>
                                <li><a href="${ path }/friends/search">친구 찾기</a></li>
                            </ul>
                        </li>
        
                        <li><a onclick="location.href='${pagecontext.request.contextPath}/group/main'">소모임</a>
                            <ul>
                                <li><a onclick="location.href='${pagecontext.request.contextPath}/group/list'">내 모임</a></li>
                            </ul>
                        </li>
        
                        <li><a onclick="location.href='${pagecontext.request.contextPath}/my_page/recent?page=1'">마이페이지</a> 
                            <ul>
                                <li><a onclick="location.href='${pagecontext.request.contextPath}/my_page/recent?page=1'">최신피드</a></li>
                                <li><a onclick="location.href='${pagecontext.request.contextPath}/my_page/myFeed?page=1'">내 피드</a></li>
                                <li><a onclick="location.href='${pagecontext.request.contextPath}/my_page/recommended?page=1'">추천피드</a></li>
                                <li><a onclick="location.href='${pagecontext.request.contextPath}/member/myinfo'">프로필수정</a></li>
                            </ul>
                        </li>
                    </ul>
                </nav>
      

        </header>