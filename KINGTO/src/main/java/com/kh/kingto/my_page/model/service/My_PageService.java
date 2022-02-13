package com.kh.kingto.my_page.model.service;

import java.sql.Connection;
import java.util.List;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.dao.FeedDao;
import com.kh.kingto.my_page.model.vo.Feed;
import com.kh.kingto.my_page.model.vo.Replies;

public class My_PageService { 
	

	private FeedDao dao = new FeedDao();

	
	public Feed findFeedByNo(int no) {
		Feed feed = null;
		
		Connection connection = getConnection();
		
		feed = dao.getFeedByNo(connection, no);
		
		close(connection);
		
		return feed;
	}
	
	public int getMypageFeedCount(String pageStatus, Member loginMember) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getMypageFeedCount(connection, pageStatus, loginMember);
		
		close(connection);
		
		return count;
	}

	
	public List<Feed> getMypageFeedList(PageInfo pageInfo, String pageStatus, Member loginMember) {
		List<Feed> list = null;
		Connection connection = getConnection();
		
		list = dao.getMypageFeedList(connection, pageInfo, pageStatus, loginMember);
		
		close(connection);
		
		return list;
	}
	
	public int getRecentFeedCount(String pageStatus) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getRecentFeedCount(connection, pageStatus);
		
		close(connection);
		
		return count;
	}

	public List<Feed> getRecentFeedList(PageInfo pageInfo, String pageStatus) {
		List<Feed> list = null;
		Connection connection = getConnection();
		
		list = dao.getRecentFeedList(connection, pageInfo, pageStatus);
		
		close(connection);
		
		return list;
	}
	
	public int getRecommendeFeedCount(String pageStatus, Member loginMember) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getRecommendeFeedCount(connection, pageStatus, loginMember);
		
		close(connection);
		
		return count;
	}

	public List<Feed> getRecommendeFeedList(PageInfo pageInfo, String pageStatus, Member loginMember) {
		List<Feed> list = null;
		Connection connection = getConnection();
		
		list = dao.getRecommendeFeedList(connection, pageInfo, pageStatus, loginMember);
		
		close(connection);
		
		return list;
	}


	
	

	
	public int save(Feed feed) {
		int result = 0;
		Connection connection = getConnection();
		
		if (feed.getNo() != 0) {
			result = dao.upDatafeed(connection,feed);
		}else {
			result = dao.insertfeed(connection,feed);
		}
		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	public int saveReplies(Replies replies) {
		int result = 0;
		Connection connection = getConnection();
		

		result = dao.insertfeed_Replies(connection,replies);

		
		if (result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

	
	
	
	
	
	public int delete(int no) {
		int result = 0 ;
		Connection connection = getConnection();
		
		result = dao.updateStatus(connection, no, "N");
		
		if(result>0) {
			commit(connection);
		}else {
			rollback(connection);
		}
		
		close(connection);
		return result;
	}

	public int replies_delete(int no) {
		int result = 0 ;
		Connection connection = getConnection();
		
		result = dao.repliesStatus(connection, no, "N");
		
		if(result>0) {
			commit(connection);
		}else {
			rollback(connection);
		}
		
		close(connection);
		return result;
	}






	




}
