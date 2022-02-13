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

@WebServlet("/friend/confirm")
public class FriendConfirmServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private FriendService service = new FriendService();
	
    public FriendConfirmServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 1. friends/list.jsp에서 수락 버튼 클릭 -> 본인 no, 신청자 no 가져오기
    	int result = 0;   
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	
    	int frndOne = Integer.parseInt(request.getParameter("no")); // 신청자
    	
    	// 2. 친구 상태 update 서비스에게 넘겨줌 -> dao 넘겨줌 -> 신청자 Y 본인 Y 업데이트
    	if(loginMember != null) {
    		Friend friend = new Friend();
    	
    		friend.setFrndOne(frndOne);
    		friend.setFrndTwo(loginMember.getMemberNo());
    		
    		result = service.confirm(friend);
    		
    		System.out.println("get");
    		
    		if(result > 0) {
         		request.setAttribute("msg", "친구 수락 완료");
         		
         		request.setAttribute("location", "/friends/list");
			} else {
				request.setAttribute("msg", "친구 요청 처리 실패");
         		request.setAttribute("location", "/friends/list");
			}
    		
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}
	}   
    

}
