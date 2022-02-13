package com.kh.kingto.member.controller.delete;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns="/delete_success")
public class Delete_Success_Servlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public Delete_Success_Servlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	request.getRequestDispatcher("/views/member/delete/delete_success.jsp").forward(request, response);
	}


}
