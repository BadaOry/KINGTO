package com.kh.kingto.my_page.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.service.My_PageService;


@WebServlet("/my_page/feed_delete")
public class FeedDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	My_PageService service = new My_PageService();

    public FeedDeleteServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//세션위치에 저장되어있는 회원정보 가져오기
		HttpSession session = request.getSession(false);
    	Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;
    	String WriterID = request.getParameter("wirterId");
    	
    	int result = 0;
    	
    	//로그인 여부 확인
		if (loginMember != null ){
			//피드 작성자인지 아이디 확인
			if (loginMember.getId().equals(WriterID)) {
				int no = Integer.parseInt(request.getParameter("no"));
				
				//result로 service클라스의 delete(int ?) 메소드 실행
				result = service.delete(no);
		
				if(result > 0) {
					request.setAttribute("msg", "게시글 삭제 성공");
				} else {
					request.setAttribute("msg", "게시글 삭제 실패");
				}
			} else {
				request.setAttribute("msg", "해당 댓글의 작성자가 아닙니다.");
			}
		} else {
			request.setAttribute("msg", "로그인후 이용이 가능합니다.");
		}
		
		
		request.setAttribute("location", "/my_page/myFeed");
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
    }



}
