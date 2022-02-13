package com.kh.kingto.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.notice.model.service.NoticeService;


@WebServlet("/notice/delete")
public class NoticeDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private NoticeService service = new NoticeService();
    
    public NoticeDeleteServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
		Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
		int no = Integer.parseInt(request.getParameter("no"));
    	int result = 0;
    	String role = loginMember != null ? loginMember.getMemberRole() : null;
    	
    		
    		
    	if(role == null || !(role.equals("관리자"))) {    
    		request.setAttribute("msg", "잘못된 접근입니다.");
    		request.setAttribute("location", "/");
    	} else {
    		result = service.delete(no);
    		if(result > 0) {
    			request.setAttribute("msg", "게시글 삭제 성공");
    			request.setAttribute("location", "/notice/list");
    		}else {
    			request.setAttribute("msg", "게시글 삭제 실패");
    			request.setAttribute("location", "/notice/list");
    		}
    	}
    	
		
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
		
	}

}
