package com.kh.kingto.member.controller.delete;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;

@WebServlet(urlPatterns="/member/delete_eng")
public class DeleteServlet_eng extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


    public DeleteServlet_eng() {
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int result = 0;
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	
    	if(loginMember != null) {
    		result = new MemberService().delete(loginMember.getMemberNo());
    		
    		if(result > 0) {
        		request.setAttribute("msg", "Thanks for being our KINGTO's member. \\nUnregister Request Success.");
        		request.setAttribute("location", "/logout");
//    			request.setAttribute("location", "/delete_success");
    		} else {
        		request.setAttribute("msg", "Unregister Failed.");
    			request.setAttribute("location", "/member/myinfo");
    		}
    	} else {
    		request.setAttribute("msg", "Please login before unregister.");
			request.setAttribute("location", "/");
    	}
    	
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
