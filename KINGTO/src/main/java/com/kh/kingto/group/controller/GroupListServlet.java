package com.kh.kingto.group.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.group.model.service.GroupService;
import com.kh.kingto.group.model.vo.GroupList;
import com.kh.kingto.member.model.vo.Member;

@WebServlet("/group/list")
public class GroupListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	private GroupService service = new GroupService();
	
    public GroupListServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 1. 소모임 리스트 조회
    	// 2. 페이징 처리
    	int page = 0;
    	int listCount = 0;
    	PageInfo pageInfo = null;
    	List<GroupList> list = null;
    	
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	
    	if(loginMember != null) {
    		int no = loginMember.getMemberNo();
    		
    		try {
    			page = Integer.parseInt(request.getParameter("page"));
    		} catch (NumberFormatException e) {
    			page = 1;
    		}
    		
    		
    		listCount = service.getMyGroupCount(no);
    		
    		pageInfo = new PageInfo(page, 10, listCount, 6);
    		
    		list = service.getMyGroupList(pageInfo,no);
    		
    		System.out.println("listCount : " + listCount);
//    		System.out.println("list : " + list);
    		
    		request.setAttribute("pageInfo", pageInfo);
    		request.setAttribute("list", list);
    		request.getRequestDispatcher("/views/group/list.jsp").forward(request, response);
    		
    	} else {
    		request.setAttribute("msg", "로그인이 필요한 페이지입니다.");
    		request.setAttribute("location", "/");      		
    		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
    	}
	}
}
