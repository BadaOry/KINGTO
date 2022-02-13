package com.kh.kingto.friends.controller;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.friends.model.service.FriendService;
import com.kh.kingto.friends.model.vo.FriendsPageInfo;
import com.kh.kingto.friends.model.vo.FriendsSearchFilter;
import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;


@WebServlet("/friends/search")
public class FriendsSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	private MemberService service = new MemberService();
	
	private FriendService fservice = new FriendService();
	

    public FriendsSearchServlet() {
    }

    @Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null;     	
    	

    	// 1. 멤버 리스트 조회    	
    	// 2. 페이징 처리
    	int page = 0; // 현재 페이지
    	int memberCount = 0; // 전체 멤버 수
    	FriendsPageInfo pageInfo = null;
    	List<Member> list = null;

    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
    	} catch (NumberFormatException e) {
    		page = 1; // 처음에 1페이지 보이도록
    	}
    	
    	
    	memberCount = service.getMemberCount();
    	
    	pageInfo = new FriendsPageInfo(page, 10, memberCount, 6);
    	
    	list = service.getMemberList(pageInfo);    	
    	    	
    		
    	request.setAttribute("pageInfo", pageInfo);
    	request.setAttribute("list", list);
    	
//    	System.out.println(list);

    	request.getRequestDispatcher("/views/friends/search.jsp").forward(request, response);
	}

    @Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	HttpSession session = request.getSession(false); 
    	Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null; 
    	
    	// 필터 만족하는 멤버 리스트 조회
    	request.setCharacterEncoding("UTF-8");
    	response.setContentType("text/html; charset=UTF-8");
    	
    	int result = 0;
    	int page = 0; // 현재 페이지
    	int memberCount = 0; // 조건에 해당하는 멤버 수
    	PageInfo pageInfo = null;
    	List<Member> list = null;
    	FriendsSearchFilter search = new FriendsSearchFilter();
    	
    	try {
    		page = Integer.parseInt(request.getParameter("page"));
    	} catch (NumberFormatException e) {
    		page = 1; // 처음에 1페이지 보이도록
    	}
    	
    	// 폼 파라미터로 검색 조건 받아와 FriendsSearchFilter 객체로 생성
    	int lcOne = Integer.parseInt(request.getParameter("lang"));
    	int localCode = Integer.parseInt(request.getParameter("zone"));
    	
    	// 미선택 필터 처리
    	if(lcOne == 0) {
    		search.setLcOne("0|1|2|3|4|5|6|7|8|9|10|11|12|13|14");
    	} else {
    		search.setLcOne(request.getParameter("lang"));    		
    	}
        
    	if(localCode == 19) {
    		search.setLocalCode("1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18");
    	} else {
    		search.setLocalCode(request.getParameter("zone"));    		
    	}
        
        if(request.getParameterValues("interest") == null) {
        	search.setInterest("운동|음악|연예|미식|여행|게임|독서|미술|자기계발|반려동물");
        } else {
        	search.setInterest(String.join("|", (request.getParameterValues("interest"))));
        }

        memberCount = fservice.getMemberCount(search);
        
        pageInfo = new PageInfo(page, 10, memberCount, 6);
        
        list = fservice.getFilteredMemberList(pageInfo, search);
        
//        System.out.println(list);
                
        request.setAttribute("pageInfo", pageInfo);
    	request.setAttribute("list", list);
    	request.getRequestDispatcher("/views/friends/search.jsp").forward(request, response);
	}
}
