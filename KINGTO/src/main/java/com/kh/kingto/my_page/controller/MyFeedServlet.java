package com.kh.kingto.my_page.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.service.My_PageService;
import com.kh.kingto.my_page.model.vo.Feed;


@WebServlet("/my_page/myFeed")
public class MyFeedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private My_PageService service = new My_PageService();
       

    public MyFeedServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 체크 확인 로직
		HttpSession session = request.getSession(false);
    	Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;

		if (loginMember != null) {
	    	String pageStatus = "mypage";
	    	
	    	int page = 0;               
	    	int FeedCount = 0;          
	    	PageInfo pageInfo = null;   
	    	List<Feed> list = null;     
	    	
	    	try {                       
	    	   	page = Integer.parseInt(request.getParameter("page"));
//	    	   	page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;   // ó�� ���ӽ� null ������ ���׿����ڷ� ��� �ٸ���� 
			} catch (NumberFormatException e) {
				page = 1;
			}
	    	
	    	FeedCount = service.getMypageFeedCount(pageStatus,loginMember);
	    	pageInfo = new PageInfo(page, 10, FeedCount, 5);
	    	list = service.getMypageFeedList(pageInfo,pageStatus,loginMember);
	    	
	    	System.out.println(FeedCount);
	    	System.out.println(list);
	    	
	    	request.setAttribute("pageInfo", pageInfo);
	    	request.setAttribute("list", list);
	    	request.getRequestDispatcher("/views/my_page/myFeed.jsp").forward(request, response);
		} else {
	    	request.getRequestDispatcher("/views/my_page/myFeed.jsp").forward(request, response);
		}

	}



}
