package com.kh.kingto.member.controller.delete;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns="/member/delete_confirm_eng")
public class Delete_Confirm_Servlet_eng extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public Delete_Confirm_Servlet_eng() {

    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
    	request.getRequestDispatcher("/views/member/delete/delete_confirm_eng.jsp").forward(request, response);
	}


}
