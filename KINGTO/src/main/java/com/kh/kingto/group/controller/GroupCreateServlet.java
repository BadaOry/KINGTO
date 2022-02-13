package com.kh.kingto.group.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.group.model.service.GroupService;
import com.kh.kingto.group.model.vo.GroupList;
import com.kh.kingto.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/group/create")
public class GroupCreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public GroupCreateServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/views/group/create.jsp").forward(request, response);
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	int result = 0;
    	
    	// 파일이 저장될 경로
    	String path = getServletContext().getRealPath("/resources/upload/group");
    	 
    	// 파일의 사이즈 지정 (10MB)
    	int maxSize = 10485760;
    	
    	// 문자에 대한 인코딩 설정
    	String encoding = "UTF-8";
    	
    	/*
    	 * DefaultFileRenamePolicy
    	 *   - 업로드되는 파일에 대한 rename 처리에 사용된다.
    	 *   - 중복되는 이름 뒤에 0 ~ 9999 붙인다.
    	 */
    	
    	MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding, new DefaultFileRenamePolicy());
    	
    	// 폼 파라미터로 넘어온 값들(파일에 대한 정보 X)
    	String sgroup_name = mr.getParameter("sgroup_name");
    	String sgroup_admin = mr.getParameter("sgroup_admin");
    	String sgroup_open = mr.getParameter("sgroup_open");
    	String sgroup_introduce = mr.getParameter("sgroup_introduce");
    	String sgroup_interest = mr.getParameter("sgroup_interest");
    	
    	// 파일에 대한 정보를 가져올 때
    	String originalFileName = mr.getOriginalFileName("upfile");
    	String filesystemName = mr.getFilesystemName("upfile");
    	
    
//    	System.out.println(sgroup_name);
    	System.out.println("originalFileName" + originalFileName);
    	System.out.println("filesystemName" + filesystemName);
    	
    	// 로그인 안된 사용자가 소모임 생성이 불가능하도록 체크하는 로직
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	
    	if(loginMember != null) {    
    		GroupList groupList = new GroupList();
    		
    		groupList.setSgroup_name(sgroup_name);
    		groupList.setSgroup_admin(loginMember.getMemberNo());
    		groupList.setSgroup_img(originalFileName);
    		groupList.setSgroup_introduce(sgroup_introduce);
    		groupList.setSgroup_interest(sgroup_interest);
    		
    		result = new GroupService().createGroup(groupList);
    		
    		if(result > 0) {
    			request.setAttribute("msg", "소모임이 생성되었습니다.");
    			request.setAttribute("location", "/group/list");
        	} else {
    			request.setAttribute("msg", "소모임 생성이 실패되었습니다.");
    			request.setAttribute("location", "/group/list");
        	}

    	} else {
    		request.setAttribute("msg", "로그인이 필요한 페이지입니다.");
    		request.setAttribute("location", "/");     		
    	}
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);

    }
}
