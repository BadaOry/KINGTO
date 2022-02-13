package com.kh.kingto.friends.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.friends.model.service.FriendService;
import com.kh.kingto.friends.model.vo.FriendsList;
import com.kh.kingto.friends.model.vo.FriendsPageInfo;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;



@WebServlet("/friends/list")
public class FriendsListServlet extends HttpServlet {
private static final long serialVersionUID = 1L;
	
	private FriendService fservice = new FriendService();

    public FriendsListServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 친구 목록
    	// * '친구이다' = 신청자 Y 대상자 Y 
    	// 1. 친구인 멤버 리스트 조회    	
    	// 2. 페이징 처리
    	int page = 0; // 현재 페이지
    	int friendCount = 0; // 전체 친구 수
    	FriendsPageInfo pageInfo = null;
    	List<FriendsList> list = null;
    	
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;    	
    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
    	} catch (NumberFormatException e) {
    		page = 1; // 처음에 1페이지 보이도록
    	}
    	
    	if(loginMember!= null ) {
    		friendCount = fservice.getFriendCount(loginMember.getMemberNo());
    		
    		pageInfo = new FriendsPageInfo(page, 10, friendCount, 6); // 한 페이지에 6명
    		
    		list = fservice.getFriendList(pageInfo, loginMember.getMemberNo());
    		
//    	System.out.println(list.toString());
    		
    		request.setAttribute("pageInfo", pageInfo); // 현재 페이지 정보를 Attribute에 담아 list.jsp에게 포워딩
    		request.setAttribute("list", list);
    		
    		
    		// 대기중인 친구 신청 목록
    		int requestCount = 0; // 대기중인 신청 수
    		List<Member> friendRequests = null;
    		
    		requestCount = fservice.getRequestCount(loginMember.getMemberNo());
    		
    		friendRequests = fservice.getRequestList(loginMember.getMemberNo(), requestCount);
    		
    		request.setAttribute("friendRequests", friendRequests);
    		
//    	System.out.println(friendRequests.toString());
    		
    	}
    	
    	request.getRequestDispatcher("/views/friends/list.jsp").forward(request, response);
	}
    

    
    
    
}
