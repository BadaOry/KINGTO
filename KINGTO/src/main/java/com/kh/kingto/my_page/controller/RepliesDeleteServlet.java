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


@WebServlet("/my_page/replies_delete")
public class RepliesDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private My_PageService service = new My_PageService();

    public RepliesDeleteServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
    	Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;
    	String currentPage = request.getParameter("currentPage");
    	String WriterID = request.getParameter("writer_id");
    	
		if (loginMember != null ){
			if (loginMember.getId().equals(WriterID)) {
		    	int result = 0;
				int no = Integer.parseInt(request.getParameter("no"));

				System.out.println(no);
		    	
				result = service.replies_delete(no);
		
		
				if (result > 0) {
					request.setAttribute("msg", "댓글 삭제 되었습니다.");
				} else {				
					request.setAttribute("msg", "댓글 삭제가 실패하였습니다.");
				}
			} else {
				request.setAttribute("msg", "해당 댓글의 작성자가 아닙니다.");
			}
		} else {
			request.setAttribute("msg", "로그인후 이용이 가능합니다.");
		}
		
		request.setAttribute("location", "/my_page"+currentPage);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		
    }
		

}
