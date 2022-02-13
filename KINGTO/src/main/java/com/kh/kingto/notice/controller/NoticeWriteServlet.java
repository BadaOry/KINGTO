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
import com.kh.kingto.notice.model.vo.Notice;


@WebServlet("/notice/nwrite")
public class NoticeWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private NoticeService service = new NoticeService();
   
    public NoticeWriteServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	String viewName = "/views/notice/nwrite.jsp";
    	String role = loginMember != null ? loginMember.getMemberRole() : null;
    	
    	if(role == null || !(role.equals("관리자"))) {    
    		viewName = "/views/common/msg.jsp";
    		request.setAttribute("msg", "로그인 후 사용할 수 있습니다.");
			request.setAttribute("location", "/");
    	}
    	
    	request.getRequestDispatcher(viewName).forward(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		
		
		
		// 로그인 안된 사용자가 게시글 작성이 불가능하도록 체크하는 로직
    	
//    	if(loginMember != null) {
    		Notice notice = new Notice();
    		System.out.println(Integer.parseInt(request.getParameter("no")));
    		System.out.println(request.getParameter("title"));
    		
    		
    		notice.setWriterNo(Integer.parseInt(request.getParameter("no")));
    		notice.setTitle(request.getParameter("title"));
    		notice.setContent(request.getParameter("content"));
    		
    		result = service.save(notice);
    		
    		if(result > 0) {
    			request.setAttribute("msg", "게시글 등록 성공!");
    			request.setAttribute("location", "/notice/list");
        	}else {
    			request.setAttribute("msg", "게시글 등록 실패!");
    			request.setAttribute("location", "/notice/list");
        	}
//    	}else {
//    		request.setAttribute("msg", "로그인 후 작성해 주세요.");
//			request.setAttribute("location", "/");
//			
//    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
