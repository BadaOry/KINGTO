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


@WebServlet("/notice/update")
public class NoticeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public NoticeUpdateServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	String viewName = "/views/notice/update.jsp";
		Notice notice = null;
		int no = Integer.parseInt(request.getParameter("no"));
		
		String role = loginMember != null ? loginMember.getMemberRole() : null;
		
		
		if(role == null || !(role.equals("관리자"))) {    
			viewName = "/views/common/msg.jsp";
			request.setAttribute("msg", "잘못된 접근입니다.");
			request.setAttribute("location", "/");
		}
		
		
		notice = new NoticeService().findNoticeByNo(no, false);
		request.setAttribute("notice", notice);
		
    	
    	request.getRequestDispatcher(viewName).forward(request, response);
		
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		Notice notice = null;
		notice = new Notice();
		request.setCharacterEncoding("utf-8"); 
		response.setContentType("text/html;charset=utf-8"); 
		
		notice.setNo(Integer.parseInt(request.getParameter("no")));
		notice.setTitle(request.getParameter("title"));
		notice.setContent(request.getParameter("content"));
		
		result = new NoticeService().save(notice);
		
		if(result > 0) {
			request.setAttribute("msg", "게시글 수정 성공");
		}else {
			request.setAttribute("msg", "게시글 수정 실패");
		}
		
		request.setAttribute("location", "/notice/view?no=" + notice.getNo());
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
	}

}
