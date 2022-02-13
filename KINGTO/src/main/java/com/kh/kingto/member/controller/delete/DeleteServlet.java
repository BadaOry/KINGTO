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

@WebServlet(urlPatterns="/member/delete")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       


    public DeleteServlet() {
    }

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int result = 0;
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	
    	if(loginMember != null) {
    		result = new MemberService().delete(loginMember.getMemberNo());
    		
    		if(result > 0) {
        		request.setAttribute("msg", "KINGTO 서비스를 이용해주셔서 감사합니다. \\n정상적으로 탈퇴되었습니다.");
        		request.setAttribute("location", "/logout");
//    			request.setAttribute("location", "/delete_success");
    		} else {
        		request.setAttribute("msg", "탈퇴에 실패하였습니다.");
    			request.setAttribute("location", "/member/myinfo");
    		}
    	} else {
    		request.setAttribute("msg", "로그인 후 삭제해 주세요.");
			request.setAttribute("location", "/");
    	}
    	
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
