package com.kh.kingto.friends.filter;

import java.io.IOException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.kh.kingto.friends.model.service.FriendService;
import com.kh.kingto.friends.model.vo.Friend;
import com.kh.kingto.member.model.service.MemberService;
import com.kh.kingto.member.model.vo.Member;


@WebFilter(filterName="friendCheck", servletNames= {"friendsView", "friendRequest"})
public class FriendCheckFilter implements Filter {

    public FriendCheckFilter() {
    }


	public void destroy() {
	}

	private MemberService service = new MemberService();
	
	private FriendService fservice = new FriendService();

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpSession session = ((HttpServletRequest)request).getSession(false);
		Member loginMember = session != null ? (Member) session.getAttribute("loginMember") : null; // 본인
		Friend friend = null;
		boolean isFriend = false;
	
		if(loginMember != null) {
			// 친구 여부 확인
			int no = Integer.parseInt(request.getParameter("no"));    	
			Member member = service.findMemberByNo(no); // 상대
			
			// true : 친구이다 (Y Y)
			isFriend = fservice.isFriend(loginMember.getMemberNo(), member.getMemberNo());
			
//			System.out.println("filter : " + isFriend);
			
		} 
		
		request.setAttribute("isFriend", isFriend);					
		
		chain.doFilter(request, response);
	}


	public void init(FilterConfig fConfig) throws ServletException {
	}

}
