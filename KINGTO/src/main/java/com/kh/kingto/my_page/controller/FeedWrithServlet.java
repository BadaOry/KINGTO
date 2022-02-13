package com.kh.kingto.my_page.controller;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.common.util.FileRename;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.service.My_PageService;
import com.kh.kingto.my_page.model.vo.Feed;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;


@WebServlet("/my_page/feed_write")
public class FeedWrithServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
      
	private My_PageService service = new My_PageService();

    public FeedWrithServlet() {
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 체크 확인 로직 구현
		HttpSession session = request.getSession(false);
    	Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;
    	String viewsName = "/views/my_page/write.jsp";
		if (loginMember == null) {
			viewsName = "/views/common/msg.jsp";
			request.setAttribute("msg", "로그인 후 이용해주세요");
			request.setAttribute("location", "/my_page/myFeed");
		}
		
		request.getRequestDispatcher(viewsName).forward(request, response);
	}

	
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 체크 확인 로직 구현 해야함
		HttpSession session = request.getSession(false);
    	Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;
		
		int result = 0;
		
		//request.setCharacterEncoding("utf-8");//post형식을 get형식으로 변환
		String path = getServletContext().getRealPath("/resources/upload/feed");
		int maxSize = 10485760;
		String encoding = "UTF-8";
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new FileRename());
		
		
		//로그인 안된 사용자가 게시글이 작성이 불가능하고록 하는 로직 생성해야함
		if (loginMember != null) {
		
		String content = mr.getParameter("content");
		String filesystemName = mr.getFilesystemName("input_image");
		String originalFileName = mr.getOriginalFileName("input_image");
			
		Feed feed = new Feed();
		feed.setWriterNo(loginMember.getMemberNo()); //로그인정보에서 작성자의 번호를 가져옴
		feed.setContent(content);
		feed.setInterest(loginMember.getInterest());
		feed.setOriginalFileName(originalFileName);
		feed.setRenameFileName(filesystemName);
		
		
		// 정수 타입이 리턴됨
		result = service.save(feed);
		
		//게시글 등록 확인
			if (result > 0) {
				request.setAttribute("msg", "게시글 등록 하였습니다.");
				request.setAttribute("location", "/my_page/myFeed");
			} else {
				request.setAttribute("msg", "게시글 등록에 실패하였습니다.");
				request.setAttribute("location", "/my_page/myFeed");
			}
		} else {
			request.setAttribute("msg", "로그인 후 이용해주세요");
			request.setAttribute("location", "/my_page/myFeed");
		}
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);	
	}

}
