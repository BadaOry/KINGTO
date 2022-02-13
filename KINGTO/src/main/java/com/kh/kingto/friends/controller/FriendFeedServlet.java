package com.kh.kingto.friends.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.friends.model.service.FriendService;
import com.kh.kingto.my_page.model.vo.Feed;

// 프로필에서 '피드 보기' 버튼 클릭 시 해당 회원의 피드를 볼 수 있음
@WebServlet("/friend/feed")
public class FriendFeedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;       

	private FriendService service = new FriendService();
	
    public FriendFeedServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no")); // 회원 번호
		int page = 0; // 현재 페이지		
		int feedCount = 0; // 회원의 전체 피드 수
		PageInfo pageInfo = null;
		List<Feed> list = null;  
		
		try {
    		page = Integer.parseInt(request.getParameter("page"));
    	} catch (NumberFormatException e) {
    		page = 1; // 처음에 1페이지 보이도록
    	}
		
		feedCount = service.getFeedCount(no);
		pageInfo = new PageInfo(page, 10, feedCount, 5);
		list = service.getFeedList(pageInfo, no);
		
		if(feedCount == 0) {
			request.setAttribute("msg", "해당 회원은 아직 피드를 작성하지 않았습니다");
    		request.setAttribute("location", "/friends/list");
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		} else {
			
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("list", list);
			request.getRequestDispatcher("/views/friends/feed.jsp").forward(request, response);
		}
		
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
