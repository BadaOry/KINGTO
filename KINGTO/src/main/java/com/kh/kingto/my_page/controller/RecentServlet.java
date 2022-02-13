package com.kh.kingto.my_page.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.common.util.FileRename;
import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.service.My_PageService;
import com.kh.kingto.my_page.model.vo.Feed;
import com.kh.kingto.my_page.model.vo.Replies;
import com.oreilly.servlet.MultipartRequest;


@WebServlet("/my_page/recent")
public class RecentServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//
	private My_PageService service = new My_PageService();
	
    public RecentServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			HttpSession session = request.getSession(false);
    		Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;

    		
	    	String pageStatus = "recent";
	    	
	    	int page = 0;               //
	    	int FeedCount = 0;          //
	    	PageInfo pageInfo = null;   //
	    	List<Feed> list = null;     //
	    	
	    	
	    	try {                       //
	    	   	page = Integer.parseInt(request.getParameter("page"));
//	    	   	page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
			} catch (NumberFormatException e) {
				page = 1;
			}
	    	
	    	FeedCount = service.getRecentFeedCount(pageStatus);
	    	pageInfo = new PageInfo(page, 10, FeedCount, 5);
	    	list = service.getRecentFeedList(pageInfo,pageStatus);
	    	
	    	System.out.println(FeedCount);
	    	System.out.println(list);
	    	
	    
	    	request.setAttribute("pageInfo", pageInfo);
	    	request.setAttribute("list", list);
	    	request.getRequestDispatcher("/views/my_page/recent.jsp").forward(request, response);
	    	

    	
	}
    
    
}


