package com.kh.kingto.friends.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.friends.model.service.FriendService;
import com.kh.kingto.friends.model.vo.Friend;
import com.kh.kingto.member.model.vo.Member;

@WebServlet(name = "friendRequest", urlPatterns = "/friend/request")
public class FriendRequestServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private FriendService service = new FriendService();
	
    public FriendRequestServlet() {
    }
    
    @Override
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 1. friends/profile.jsp에서 친구추가 버튼 클릭 -> 신청자 no와 대상자 no 받아오기
    	int result = 0;   
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null; // 로그인서블릿에서 session에 담아주는 로그인유저(요청자) 가져와야함
    	
    	// 대상자 : memberNo = no인 회원에게 친구 신청 보내기
    	int frndTwo = Integer.parseInt(request.getParameter("no")); 
    	
    	// 2. 친구 생성 서비스에게 넘겨주기 -> dao 넘겨주기 
    	if(loginMember != null) {
    		Friend friend = new Friend();
    		
    		friend.setFrndOne(loginMember.getMemberNo());
    		friend.setFrndTwo(frndTwo);
    		
//    		System.out.println(friend.getFrndOne() + ", " + friend.getFrndTwo());
//    		System.out.println(request.getAttribute("isFriend") + ", " + request.getAttribute("formerFriend"));

    		result = service.request(friend);
    		
    		if(result > 0) {
         		request.setAttribute("msg", "친구 추가 요청 성공");
         		request.setAttribute("location", "/friends/search");
			} else {
				request.setAttribute("msg", "친구 추가 요청이 대기중입니다");
         		request.setAttribute("location", "/friends/search");
			}
    		
    	} else {
    		request.setAttribute("msg", "로그인 후 사용할 수 있습니다.");
    	}
    	
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    }
    
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 1. friends/profile.jsp에서 친구추가 버튼 클릭 -> 신청자 no와 대상자 no 받아오기
    	int result = 0;   
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null; // 로그인서블릿에서 session에 담아주는 로그인유저(요청자) 가져와야함
    	
    	int frndTwo = Integer.parseInt(request.getParameter("frndTwo")); // 대상자   	
    	
    	// 2. 친구 생성 서비스에게 넘겨주기 -> dao 넘겨주기 -> frnd 테이블에 신청자 Y 대상자 N insert
    	if(loginMember != null) {
    		Friend friend = new Friend();
    		
    		friend.setFrndOne(loginMember.getMemberNo());
    		friend.setFrndTwo(frndTwo);
    		
    		result = service.request(friend);
    		
    		if(result > 0) {
         		request.setAttribute("msg", "친구 추가 요청 성공");
         		request.setAttribute("location", "/friends/profile?no=" + frndTwo);
			} else {
				request.setAttribute("msg", "친구 추가 요청 실패");
         		request.setAttribute("location", "/friends/profile?no=" + frndTwo);
			}
    	} else {
    		request.setAttribute("msg", "로그인 후 사용할 수 있습니다.");
    	}
    	
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	
    	// 3. b의 friends/list.jsp 신청 목록에 조회됨
    	// 4. b가 수락 누름 -> frndadd서블릿에 전달
    	// 5. frndadd가 서비스에게 넘겨줌 -> dao 넘겨주기 -> frnd 테이블에 a y b y update
    	// 6. a와 b의 friends/list.jsp 친구 목록에 조회됨
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
    	
	}

   

}
