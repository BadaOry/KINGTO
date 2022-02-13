package com.kh.kingto.member.controller.update;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.common.util.EncryptUtil;
import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;


@WebServlet(name="update_eng", urlPatterns="/member/update_eng")
public class MemberUpdateServlet_eng extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public MemberUpdateServlet_eng() {

    }
    
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1. 로그인 된 회원인지 체크
		// 2. 수정하기 전에 
		// 3. 비밀번호가 맞으면 수정페이지로 들어갈 수 있도록 구현
		// 4. 수정된 값들 service의 MemberUpdate() 에 넘겨주고
		// 5. dao 가 쿼리 실행해서 result 들고오면 반영해주기
		
		// ★ MODIFY DATE 바꾸는거 까먹지말기
		request.setCharacterEncoding("UTF-8");
		
		HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;
    	Member member = null;
    	String hobby = null;
    	int result = 0;
    	
		String path = getServletContext().getRealPath("/resources/upload/profile");
		int maxSize = 10485760;
		String encoding = "UTF-8";
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding);
		String upfileName = mr.getOriginalFileName("upfile");
		
    	if(loginMember != null) {
    		member = new Member();
    		
    		member.setMemberNo(Integer.parseInt(mr.getParameter("userNo")));
    		member.setMemberStatus('Y');
    		member.setMemberRole("외국인");
    		
    		member.setInterest(String.join(",", mr.getParameterValues("userInt")));
    		member.setNatCode(Integer.parseInt(mr.getParameter("userNatCode")));
    		member.setLcOne(Integer.parseInt(mr.getParameter("lc_one")));
    		member.setLcOneLv(5);
    		member.setLocalCode(Integer.parseInt(mr.getParameter("userLocalCode")));
    		
    		member.setId(mr.getParameter("userId"));
    		
    		member.setPwd(EncryptUtil.oneWayEnc(mr.getParameter("userPwd"), "SHA-256"));
    		
    		member.setEmail(mr.getParameter("userEmail"));
    		member.setNickname(mr.getParameter("userNickname"));
    		member.setLcTwo(Integer.parseInt(mr.getParameter("lc_two")));
    		member.setLcTwoLv(Integer.parseInt(mr.getParameter("lc_two_lv")));
    		member.setLcThr(Integer.parseInt(mr.getParameter("lc_thr")));
    		member.setLcThrLv(Integer.parseInt(mr.getParameter("lc_thr_lv")));
    		
    		member.setOriginalFilename(upfileName);
    		
    		System.out.println(member);
    		
    		result = new MemberService().save(member);
    		
    		if(result > 0) {
    			session.setAttribute("loginMember", new MemberService().findMemberById(loginMember.getId()));
    		
        		request.setAttribute("msg", "Change user information success!");
    			request.setAttribute("location", "/member/myinfo_eng");
    		} else {
        		request.setAttribute("msg", "Submit failed \\\\nPlease recheck your information.");
    			request.setAttribute("location", "/member/myinfo_eng");
    		}
    	} else {
    		request.setAttribute("msg", "Please login before change your user information.");
			request.setAttribute("location", "/");
    	}
    	
    	request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	}

}
