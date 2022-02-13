package com.kh.kingto.group.controller;

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

@WebServlet("/group/main")
public class GroupMainServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;


    public GroupMainServlet() {
    }

    @Override

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	// 1. 게시글 리스트 조회
    	// 2. 페이징 처리
    	int page = 0;
    	int popularListCount = 0;
    	PageInfo popularPageInfo = null;
    	List<GroupList> popularList = null;
    	int recectListCount = 0;
    	PageInfo recectPageInfo = null;
    	List<GroupList> recectList = null;
    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
		} catch (NumberFormatException e) {
			page = 1;
		}
    	
    	popularListCount = new GroupService().getGroupCount();
    	recectListCount = new GroupService().getGroupCount();
    	
    	popularPageInfo = new PageInfo(page, 10, popularListCount, 4);
    	recectPageInfo = new PageInfo(page, 10, recectListCount, 4);
    	
    	popularList = new GroupService().getPopularGroupList(popularPageInfo);
    	recectList = new GroupService().getRecectGroupList(recectPageInfo);
    	
    	System.out.println("popularListCount : " + popularListCount);
    	System.out.println("popularList : " + popularList);
    	System.out.println("recectListCount : " + recectListCount);
    	System.out.println("recectList" + recectList);
    	
    	request.setAttribute("PopularpageInfo", popularPageInfo);
    	request.setAttribute("recectPageInfo", recectPageInfo);
    	
    	request.setAttribute("Popularlist", popularList);
    	request.setAttribute("RecectList", recectList);
    	request.getRequestDispatcher("/views/group/main.jsp").forward(request, response);
	}

//    @Override
//	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//		doGet(request, response);
//	}

}

