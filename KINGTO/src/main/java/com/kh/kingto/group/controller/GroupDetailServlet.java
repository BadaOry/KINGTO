package com.kh.kingto.group.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import com.kh.kingto.group.model.service.GroupService;
import com.kh.kingto.group.model.vo.GroupList;

@WebServlet("/group/mydetail")
public class GroupDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;


    public GroupDetailServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GroupList groupList = null;
    	int no = Integer.parseInt(request.getParameter("no"));
    	
    	System.out.println("sgroup_no : " + no);
    	
    	groupList = new GroupService().findGroup(no);
    	
    	System.out.println("groupList : " + groupList);
    	
    	request.setAttribute("GroupList", groupList);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

	}

}
