package com.kh.kingto.notice.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.notice.model.service.NoticeService;
import com.kh.kingto.notice.model.vo.Notice;

@WebServlet("/notice/list")
public class NoticeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private NoticeService service = new NoticeService();
    
    public NoticeListServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int page = 0;
		int listCount = 0;
		PageInfo pageInfo = null;
		List<Notice> list = null;
		
		try {
			page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page =1;
		}
		
		listCount = service.getBoardCount();
		pageInfo = new PageInfo(page, 10, listCount, 10);
		list = service.getNoticeList(pageInfo);
		
		
		request.setAttribute("pageInfo", pageInfo);
		request.setAttribute("list", list);
		request.getRequestDispatcher("/views/notice/list.jsp").forward(request, response);
	}

}
