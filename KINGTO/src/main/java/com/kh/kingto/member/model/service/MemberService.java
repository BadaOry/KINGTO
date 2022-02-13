package com.kh.kingto.member.model.service;

import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;

import java.util.List;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;
import com.kh.kingto.common.util.PageInfo;

import com.kh.kingto.friends.model.vo.FriendsPageInfo;

import com.kh.kingto.member.model.dao.MemberDao;
import com.kh.kingto.member.model.vo.Member;

public class MemberService {
	
	
	
	// DAO를 통해 전체 회원 수 얻어오는 메소드
	public int getMemberCount() {
		int count = 0;
		Connection connection = getConnection();
		
		count = new MemberDao().getMemberCount(connection);
		
		close(connection);
		
		return count;
	}
	
	// DAO를 통해 현재 페이지에 표시할 멤버 리스트 조회해오는 메소드
	public List<Member> getMemberList(FriendsPageInfo pageInfo) {
		List<Member> list = null;
		Connection connection = getConnection();
		
		list = new MemberDao().findAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}
	
	// 회원번호로 멤버 조회해오는 메소드
	public Member findMemberByNo(int no) {
		Member member = null;
		
		Connection connection = getConnection();
		
		member = new MemberDao().findMemberByNo(connection, no);
		
		close(connection);
		
		return member;
	}
		
	public Member login(String userId, String userPwd) {
		Member member = this.findMemberById(userId);




		if(member != null && member.getPwd().equals(userPwd)) {
			return member;
		} else {
			return null;
		}

	}
	
	public int save(Member member) {
		int result = 0;
		Connection connection = getConnection();
		
		if(member.getMemberNo() != 0) {
			result = new MemberDao().updateMember(connection, member);
		} else {
			result = new MemberDao().insertMember(connection, member);
		}
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}



	
	public Boolean isDuplicateID(String userId) {
		
		return this.findMemberById(userId) != null;
	}

	
	
	public Boolean isDuplicateNickname(String userNickname) {
		
		return this.findMemberByNickname(userNickname) != null;
	}
	
	


	public Member findMemberById(String userId) {
		Connection connection = getConnection();
		Member member = new MemberDao().findMemberById(connection, userId);
		
		close(connection);
		
		return member;
	}

	
	private Member findMemberByNickname(String userNickname) {
		Connection connection = getConnection();
		Member member = new MemberDao().findMemberByNickname(connection, userNickname);
		
		close(connection);
		
		return member;
	}


	
	// ▼ Member info update methods //
	public int updatePassword(int memberNo, String userPwd) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new MemberDao().updateMemberPassword(connection, memberNo, userPwd);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;

	}
  


	public int delete(int memberNo) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new MemberDao().updateMemberStatus(connection, memberNo, "N");
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	// 언어 코드로 배우고 싶은 언어 이름 받아오기
	public String getLangName(Member member) {
		String name = null;
		Connection connection = getConnection();

		name = new MemberDao().getLangName(connection, member);
		
		close(connection);
		
		return name;
	}




}
