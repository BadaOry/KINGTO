package com.kh.kingto.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.admin.model.service.AdminService;
import com.kh.kingto.admin.model.vo.Report;
import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.notice.model.vo.Notice;


@WebServlet(urlPatterns="/report_browser")
public class MemberReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public MemberReportServlet() {

    }

    @Override
   	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       	
       	request.getRequestDispatcher("/views/admin/report_browser.jsp").forward(request, response);
       }

}
