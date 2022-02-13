package com.kh.kingto.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns="/member/enroll/select")
public class Enroll_Select_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Enroll_Select_Servlet() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.getRequestDispatcher("/views/member/enroll/select.jsp").forward(request, response);	
	}
}