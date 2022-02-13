package com.kh.kingto.admin.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet(urlPatterns="/admin/report_board")
public class ReportBoardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;


    public ReportBoardServlet() {

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        request.getRequestDispatcher("/views/admin/report_board.jsp").forward(request, response);
    }

}