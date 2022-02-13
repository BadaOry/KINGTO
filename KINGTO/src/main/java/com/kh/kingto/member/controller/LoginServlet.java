package com.kh.kingto.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;


@WebServlet(name="login", urlPatterns="/member/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public LoginServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	request.getRequestDispatcher("/views/member/login.jsp").forward(request, response);	
	}


	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = null;

		String userId = request.getParameter("userId");
		String userPwd = request.getParameter("userPwd");
		String saveId = request.getParameter("saveId");
		
//		System.out.println(userId + ", " + userPwd + ", " + saveId);
		
		Member loginMember = new MemberService().login(userId, userPwd);
	
		if(loginMember != null) {
			session = request.getSession();
			
			session.setAttribute("loginMember", loginMember);
			
			System.out.println(loginMember);
			
			response.sendRedirect(request.getContextPath()+ "/");
		} else {
			request.setAttribute("msg", "아이디나 비밀번호가 일치하지 않습니다.");
			request.setAttribute("location", "/member/login");
			
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}


	}

}
