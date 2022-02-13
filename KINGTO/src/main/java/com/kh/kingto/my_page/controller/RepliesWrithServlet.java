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
import com.kh.kingto.my_page.model.vo.Replies;


@WebServlet("/replies")
public class RepliesWrithServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private My_PageService service = new My_PageService();

    public RepliesWrithServlet() {
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");//post형식을 get형식으로 변환
		//로그인 체크 확인 로직
		HttpSession session = request.getSession(false);
    	Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;

		String currentPage = request.getParameter("currentPage");
		String content = request.getParameter("feed_replies_content");

		if (loginMember != null ) {
			if (content != null && !content.trim().isEmpty()) {
				int result = 0;
				Replies replies = new Replies();
				
				replies.setFeed_no(Integer.parseInt(request.getParameter("feedNo")));
				replies.setWriter_no(loginMember.getMemberNo());
				replies.setWriter_id(loginMember.getId());
				replies.setContent(request.getParameter("feed_replies_content"));
				

				result = service.saveReplies(replies);
				
				System.out.println(result);


				if (result > 0 ) {
					request.setAttribute("msg", "댓글을 등록 하였습니다!");
				} else {				
					request.setAttribute("msg", "댓글 등록이 실패하엿습니다.");
				}
			}else {
				request.setAttribute("msg", "내용 작성후 등록이 가능합니다.");
			}
		} else {
			request.setAttribute("msg", "로그인후 이용이 가능합니다.");
		}
		request.setAttribute("location", "/my_page"+currentPage);
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);	
	}
}
