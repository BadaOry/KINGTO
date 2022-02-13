package com.kh.kingto.notice.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.kingto.notice.model.service.NoticeService;
import com.kh.kingto.notice.model.vo.Notice;


@WebServlet("/notice/view")
public class NoticeViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private NoticeService service = new NoticeService();
    
    public NoticeViewServlet() {
    }

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int no = Integer.parseInt(request.getParameter("no"));
    	
    	// 새로 고침 시 조회 수가 증가하는 것을 방지하는 로직 
		// 쿠키에 조회한 내용을 기록하여 한 번 조회하면 그 뒤에는 조회 수가 올라가지 않게 설정
		// 1. 쿠키에 조회한 이력이 있는 지 확인
		Cookie[] cookies = request.getCookies();
		String boardHistory = ""; //이력을 저장하는 변수
		boolean hasRead = false; //읽은 글이면 true, 안 읽었으면 false
		
		if(cookies != null) {
			String name = null;
			String value = null;
			
			for(Cookie cookie : cookies) {
				name = cookie.getName();
				value = cookie.getValue();
				
				//boardHistory인 쿠키 값을 찾기
				if("boardHistory".equals(name)) {
					boardHistory = value;//현재 저장된 값 대입
					if(value.contains("|" + no + "|")) {
						//읽은 게시글
						hasRead = true;
						 
						break;
					}
				}
			}
		}
		
		// 2. 읽지 않은 게시글이면 cookie에 기록
		if(!hasRead) {
			Cookie cookie = new Cookie("boardHistory", boardHistory + "|" + no + "|");
			
			cookie.setMaxAge(-1);//브라우저 종료 시 삭제
			response.addCookie(cookie);
		}
    	
    	Notice notice = service.findNoticeByNo(no, hasRead);
    	
    	System.out.println(notice);
    	
    	request.setAttribute("notice", notice);
    	request.getRequestDispatcher("/views/notice/view.jsp").forward(request, response);
	}
	
//		int no = Integer.parseInt(request.getParameter("no"));
//		
//		Notice notice = service.findNoticeByNo(no);
//		
//		request.setAttribute("notice", notice);
//		request.getRequestDispatcher("/views/notice/view.jsp").forward(request, response);
//	}

}
