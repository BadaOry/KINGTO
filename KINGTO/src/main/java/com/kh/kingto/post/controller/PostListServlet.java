package com.kh.kingto.post.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.group.model.service.GroupService;
import com.kh.kingto.group.model.vo.GroupList;
import com.kh.kingto.post.model.service.PostService;
import com.kh.kingto.post.model.vo.PostList;

@WebServlet("/group/detail")
public class PostListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PostService service = new PostService();
	
    public PostListServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 1. 게시글 리스트 조회
    	// 2. 페이징 처리
    	int page = 0;
    	int listCount = 0;
    	PageInfo pageInfo = null;
    	List<PostList> list = null;
    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
    	
    	// 
    	GroupList groupList = null;
    	int no = Integer.parseInt(request.getParameter("no"));
    	
    	groupList = new GroupService().findGroupNo(no);
    	
    	System.out.println(groupList);
    	
    	request.setAttribute("GroupList", groupList);
    	    	
    	listCount = service.getPostCount();
    	
    	pageInfo = new PageInfo(page, 10, listCount, 3);
    	
    	list = service.getPostList(pageInfo);
    	
    	System.out.println(listCount);
    	System.out.println(list);
    	
    	request.setAttribute("pageInfo", pageInfo);
    	request.setAttribute("list", list);
    	request.getRequestDispatcher("/views/group/detail.jsp").forward(request, response);
	}

}
