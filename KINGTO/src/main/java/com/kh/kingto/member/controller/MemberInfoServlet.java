package com.kh.kingto.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/member/info")
public class MemberInfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemberInfoServlet() {

    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 비밀번호 확인하는 (>개인 정보 보여주는) 페이지로 이동하기 
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 비밀번호 확인하는 페이지 하나 더 만들고
		// 비밀번호 넘겨서 맞으면 정보수정 페이지
	}

}
