package com.kh.kingto.post.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.post.model.service.PostService;
import com.kh.kingto.post.model.vo.PostList;
import com.oreilly.servlet.MultipartRequest;

@WebServlet("/post/write")
public class PostWriteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private PostService service = new PostService();

    public PostWriteServlet() {
    }
    
    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	String viewName = "/views/post/write.jsp";

    	request.setAttribute("no", Integer.parseInt(request.getParameter("no")));
    	
    	// 로그인 후 게시글 작성할 수 있도록
    	if(loginMember == null) {
    		viewName = "/views/common/msg.jsp";
    		request.setAttribute("msg", "로그인 후 사용할 수 있습니다.");
			request.setAttribute("location", "/");
    	}
    	
    	request.getRequestDispatcher("/views/post/write.jsp").forward(request, response);
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int result = 0;
		
		 // 로그인 안된 사용자가 게시글 작성이 불가능하도록 체크하는 로직
		HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	
    	int no = Integer.parseInt(request.getParameter("no")); // 소모임 번호
    	
    	if(loginMember != null) {
    		PostList post = new PostList();
    		
    		post.setPost_member(loginMember.getMemberNo()); // 회원 번호
    		post.setPost_id(loginMember.getNickname()); // 회원 닉네임
    		post.setPost_sgroup_no(no); // 소모임 번호
    		post.setPost_title(request.getParameter("title")); // 제목
    		post.setPost_cont(request.getParameter("content")); // 내용
    		
    		result = service.save(post);
    		
    		if(result > 0) {
    			request.setAttribute("msg", "게시글 등록 성공!");
    			request.setAttribute("location", "/group/detail");
        	}else {
    			request.setAttribute("msg", "게시글 등록 실패!");
    			request.setAttribute("location", "/group/detail");
        	}
    	}else {
    		request.setAttribute("msg", "로그인 후 작성해 주세요.");
			request.setAttribute("location", "/");
			
    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
		}


}