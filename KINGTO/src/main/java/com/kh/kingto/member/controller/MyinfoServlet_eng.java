package com.kh.kingto.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.member.model.vo.Member;


@WebServlet("/member/myinfo_eng")
public class MyinfoServlet_eng extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MyinfoServlet_eng() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	
    	if(loginMember != null) {    		
    		request.getRequestDispatcher("/views/member/myinfo_eng.jsp").forward(request, response);    		
    	} else {
    		request.setAttribute("msg", "Please login before check the user information.");
			request.setAttribute("location", "/");
			
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}
 
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 비밀번호 확인하는 페이지 하나 더 만들고
		// 비밀번호 넘겨서 맞으면 정보수정 페이지
	}

}
