package com.kh.kingto.friends.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;

// 프로필 조회 
@WebServlet(name="friendsView", urlPatterns = "/friends/view")
public class FriendsViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private MemberService service = new MemberService();
	
    public FriendsViewServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 사용자가 보낸 no값으로 db에서 조회하여 영역 객체에 담아 리턴
    	int no = Integer.parseInt(request.getParameter("no"));
    	
//    	System.out.println(no);
    	
    	Member member = service.findMemberByNo(no);
    	
    	// 처리 결과 -> request 에 담아 넘겨줌
    	request.setAttribute("member", member);
    	
//    	System.out.println(member);
    	
    	String lcTwo = "";
    	int lcTwoLv = 0;
    	
    	lcTwo = service.getLangName(member);
    	
//    	System.out.println(lcTwo);
    	
//    	System.out.println("FriendViewServlet에서 isFriend : " + request.getAttribute("isFriend"));

    	request.setAttribute("lcTwo", lcTwo);
    	
    	// 목록으로 돌아가기
    	request.setAttribute("referer", request.getHeader("referer"));
    	
    	request.getRequestDispatcher("/views/friends/profile.jsp").forward(request, response);
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}

