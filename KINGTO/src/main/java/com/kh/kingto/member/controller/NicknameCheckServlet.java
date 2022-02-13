package com.kh.kingto.member.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.kingto.member.model.service.MemberService;


@WebServlet(urlPatterns="/member/NicknameCheck")
public class NicknameCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public NicknameCheckServlet() {

    }

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Map<String, Boolean> map = new HashMap<>();

    	String userNickname = request.getParameter("userNickname");
    	

    	System.out.println("UserNickname : " + userNickname);
    	
    	map.put("duplicate", new MemberService().isDuplicateNickname(userNickname));
    	
    	response.setContentType("application/json; charset=UTF-8");
    	
    	new Gson().toJson(map, response.getWriter());	
	}

}
