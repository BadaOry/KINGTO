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


@WebServlet("/my_page/feed_updata")
public class upDateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private My_PageService service = new My_PageService();
	
    public upDateServlet() {

    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(false);
    	Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;
		String viewsName = null;
		
		if (loginMember != null || loginMember.getId().equals(request.getParameter("wirterId")) ) {
			 viewsName = "/views/my_page/update.jsp";
			Feed feed = null;
			int no = Integer.parseInt(request.getParameter("no"));
			
			feed = new My_PageService().findFeedByNo(no);
			
			System.out.println(feed);
			
	    	request.setAttribute("feed", feed);
			
		} else {
			viewsName = "/views/common/msg.jsp";
			request.setAttribute("msg", "로그인 후 이용해주세요.");
			request.setAttribute("location", "/");
		}
		
		request.getRequestDispatcher(viewsName).forward(request, response);
	}


	
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//로그인 체크 확인 로직 구현
		HttpSession session = request.getSession(false);
		Member loginMember = session != null?(Member) session.getAttribute("loginMember") : null;
		
		int result = 0;
		Feed feed = null;
		String originalFileName = null; // 수정할때 저장하는 파일의 이름
		String renamedFileName = null; // 수정할때 저장하는 파일의 이름
		String path = getServletContext().getRealPath("/resources/upload/feed");
		int maxSize = 10485760;
		String encoding = "UTF-8";
		
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new FileRename());
		
			//로그인 안된 사용자가 게시글이 작성이 불가능하고록 하는 로직 생성해야함
			if (loginMember != null || loginMember.getId().equals(mr.getParameter("wirterId"))){
				
				feed = new Feed();
				
				feed.setNo(Integer.parseInt(mr.getParameter("no")));
				feed.setWriterId(mr.getParameter("wirterId"));
				feed.setContent(mr.getParameter("content"));
				feed.setOriginalFileName(mr.getParameter("originalFileName"));
				feed.setRenameFileName(mr.getParameter("renameFileName"));
			
				originalFileName = mr.getOriginalFileName("input_image");
				renamedFileName = mr.getFilesystemName("input_image");

			if (originalFileName != null && !originalFileName.equals("")) {
				File file = new File(path + "/" + feed.getRenameFileName());
				
	    		if(file.exists()) {
	    			file.delete();
	    		}
	    		
				feed.setOriginalFileName(originalFileName);
				feed.setRenameFileName(renamedFileName);
			}
			
			result = service.save(feed);

			//게시글 등록 확인
			if (result > 0) {
				request.setAttribute("msg", "게시글 수정 true");
				request.setAttribute("location", "/my_page/myFeed");
			} else {
				request.setAttribute("msg", "게시글 수정 false");
				request.setAttribute("location", "/");
			}
		} else {
			request.setAttribute("msg", "로그인 후 이용해주세요.");
			request.setAttribute("location", "/");
		}	
			request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);	
		}
	}

