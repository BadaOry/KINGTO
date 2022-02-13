package com.kh.kingto.friends.model.service;

import java.sql.Connection;
import java.util.List;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.friends.model.dao.FriendDao;
import com.kh.kingto.friends.model.vo.Friend;
import com.kh.kingto.friends.model.vo.FriendsList;
import com.kh.kingto.friends.model.vo.FriendsPageInfo;
import com.kh.kingto.friends.model.vo.FriendsSearchFilter;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.vo.Feed;

public class FriendService {

	private FriendDao dao = new FriendDao();
	
	// 전달받은 frndOne, frndTwo으로 dao 통해 db에 insert하는 메소드
	public int request(Friend friend) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.friendRequest(connection, friend);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	// 전달받은 frndOne, frndTwo으로 dao 통해 db에 update하는 메소드 (친구수락)
	public int confirm(Friend friend) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.friendConfirm(connection, friend);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	// dao 통해 전체 친구 수 조회
	public int getFriendCount(int no) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getFriendsCount(connection, no);
		
		close(connection);		
		
		return count;
	}

	// dao 통해 현재 페이지에 표시할 친구 리스트 조회
	public List<FriendsList> getFriendList(FriendsPageInfo pageInfo, int no) {
		List<FriendsList> list = null;
		Connection connection = getConnection();
		
		list = dao.findAll(connection, pageInfo, no);
		
		close(connection);
		
		return list;
	}


	// 검색 필터 적용 메소드
	public List<Member> getFilteredMemberList(PageInfo pageInfo, FriendsSearchFilter search) {
		List<Member> list = null;
		Connection connection = getConnection();
		
		list = dao.findFiltered(connection, pageInfo, search);
		
		return list;
	}

	// dao 통해 조건에 해당하는 멤버 수 조회
	public int getMemberCount(FriendsSearchFilter search) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getMemberCount(connection, search);
		
		close(connection);		
		
		return count;
	}

	// 전달받은 회원번호로 친구 여부 확인
	public boolean isFriend(int memberNo, int memberNo2) {
		boolean result = false;
		
		Connection connection = getConnection();
		
		result = dao.isFriend(connection, memberNo, memberNo2);
		
		close(connection);
		
		return result;
	}

	// 전달받은 frndOne, frndTwo으로 dao 통해 db에서 delete하는 메소드 (친구삭제)
	public int delete(Friend friend) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.friendDelete(connection, friend);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	// dao 통해 대기중인 친구 신청(나 N 상대 Y) 개수 조회 메소드
	public int getRequestCount(int no) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getRequestCount(connection, no);
		
		close(connection);
		
		return count;
	}

	// dao 통해 대기중인 친구신청(나 N 상대 Y) 목록 조회 메소드
	public List<Member> getRequestList(int no, int count) {
		List<Member> list = null;
		Connection connection = getConnection();
		
		list = dao.getRequestList(connection, no, count);
		
		close(connection);
			
		return list;
	}

	// dao 통해 회원번호로 피드 수 조회
	public int getFeedCount(int no) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getFeedCount(connection, no);
		
		close(connection);
		
		return count;
	}

	// dao 통해 회원번호로 피드 리스트 조회
	public List<Feed> getFeedList(PageInfo pageInfo, int no) {
		List<Feed> list = null;
		Connection connection = getConnection();
		
		list = dao.getFeedList(connection, pageInfo, no);
		
		close(connection);
		
		return list;
	}

	
	
}
