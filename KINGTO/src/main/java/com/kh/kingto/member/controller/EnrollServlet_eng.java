package com.kh.kingto.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.kingto.common.util.EncryptUtil;
import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;
import com.oreilly.servlet.MultipartRequest;


@WebServlet(name="enroll_eng", urlPatterns="/member/enroll/input_eng")
public class EnrollServlet_eng extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public EnrollServlet_eng() {
    }

    // ▼ 회원 가입 페이지로 전환해주는 메소드
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.getRequestDispatcher("/views/member/enroll/eng/input_eng.jsp").forward(request, response);	
	}

	// ▼ service 에 데이터 전달하고 회원가입 요청할 메소드
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		
		String path = getServletContext().getRealPath("/resources/upload/profile");
		int maxSize = 10485760;
		String encoding = "UTF-8";
		MultipartRequest mr = new MultipartRequest(request, path, maxSize, encoding);
		String upfileName = mr.getOriginalFileName("upfile");
		
		Member member = new Member();
		
		member.setMemberStatus('Y');
		member.setMemberRole("외국인");
		
		member.setInterest(String.join(",", mr.getParameterValues("userInt")));
		member.setNatCode(Integer.parseInt(mr.getParameter("userNatCode")));
		member.setLcOne(Integer.parseInt(mr.getParameter("lc_one")));
		member.setLcOneLv(5);
		member.setLocalCode(Integer.parseInt(mr.getParameter("userLocalCode")));
		
		member.setId(mr.getParameter("userId"));
		
//		member.setPwd(EncryptUtil(request.getParameter("userPwd")));
		member.setPwd(EncryptUtil.oneWayEnc(mr.getParameter("userPwd"), "SHA-256"));
		
		member.setEmail(mr.getParameter("userEmail"));
		member.setNickname(mr.getParameter("userNickname"));
		member.setLcTwo(Integer.parseInt(mr.getParameter("lc_two")));
		member.setLcTwoLv(Integer.parseInt(mr.getParameter("lc_two_lv")));
		member.setLcThr(Integer.parseInt(mr.getParameter("lc_thr")));
		member.setLcThrLv(Integer.parseInt(mr.getParameter("lc_thr_lv")));
		
		member.setOriginalFilename(upfileName);
		
		System.out.println(member);
		
		int result = new MemberService().save(member);
		
		if(result > 0) {
			request.setAttribute("msg", "Join Success!");
			request.setAttribute("location", "/views/member/enroll/eng/success_eng.jsp");
		} else {
			request.setAttribute("msg", "Submit failed \\nPlease recheck your information.");
			request.setAttribute("location", "/member/enroll/input_eng");
			
		}
		
		request.getRequestDispatcher("/views/common/msg.jsp").forward(request, response);
	
	}

}
