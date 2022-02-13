package com.kh.kingto.admin.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.friends.model.service.FriendService;
import com.kh.kingto.group.model.service.GroupService;
import com.kh.kingto.group.model.vo.GroupList;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.vo.Feed;
import com.kh.kingto.notice.model.service.NoticeService;
import com.kh.kingto.my_page.model.service.My_PageService;
import com.kh.kingto.notice.model.vo.Notice;

@WebServlet("/mainpage")
public class MainPageServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private NoticeService noticeService = new NoticeService();   
	private My_PageService my_pageService = new My_PageService();   
	private GroupService groupService = new GroupService();
	private FriendService fservice = new FriendService();
   
    public MainPageServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int noticeCount = 0;
		int feedCount = 0; 
		int popularCount = 0; 
		int requestCount = 0;

		PageInfo noticePageInfo = null;
		PageInfo feedPageInfo = null;
		PageInfo popularPageInfo = null;

		List<Notice> noticeList = null;
		List<Feed> feedList = null;
		List<GroupList> popularList = null;
		List<Member> friendRequests = null;
		
		HttpSession session = request.getSession(false); 
		Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;

		String pageStatus = "recent"; // 이건 실수 헤헷~
		
		noticeCount = noticeService.getBoardCount();
		noticePageInfo = new PageInfo(1, 1, noticeCount, 3);
		noticeList = noticeService.getNoticeList(noticePageInfo);
		
    	
    	feedCount = my_pageService.getRecentFeedCount(pageStatus);
    	feedPageInfo = new PageInfo(1, 1, feedCount, 1);
    	feedList = my_pageService.getRecentFeedList(feedPageInfo,pageStatus);
    	

    	popularCount = groupService.getGroupCount();
    	popularPageInfo = new PageInfo(1, 1, popularCount, 2);
    	popularList = groupService.getPopularGroupList(popularPageInfo);
    
    	request.setAttribute("pageInfo1", noticePageInfo);
    	request.setAttribute("list1", noticeList);
    	System.out.println(noticeList);
    	
    	request.setAttribute("pageInfo2", feedPageInfo);
    	request.setAttribute("list2", feedList);
    	System.out.println(feedList);
    	
    	request.setAttribute("pageInfo3", popularPageInfo);
    	request.setAttribute("list3", popularList);
    	System.out.println(popularList);
    	
    	
    	if(loginMember != null) {
    		requestCount = fservice.getRequestCount(loginMember.getMemberNo());
    		
    		friendRequests = fservice.getRequestList(loginMember.getMemberNo(), requestCount);
    		
    		request.setAttribute("friendRequests", friendRequests);    		
    	}
    	
    	request.getRequestDispatcher("/views/common/mainPage.jsp").forward(request, response);
	}
}