package com.kh.kingto.my_page.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.jasper.tagplugins.jstl.core.If;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.vo.Feed;
import com.kh.kingto.my_page.model.vo.Replies;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

public class FeedDao {

	
	/*해당 피드 정보*/
	public Feed getFeedByNo(Connection connection, int no) {
		Feed feed = null;
		PreparedStatement pstmt = null ;

		ResultSet rs = null;
		String query = 
				"SELECT F.NO, "
				+ 		"M.NICKNAME, "
				+ 		"F.CONTENT, "
				+ 		"F.ORIGINAL_FILENAME, "
				+ 		"F.RENAMED_FILENAME, "
				+ 		"F.CREATE_DATE, "
				+ 		"F.STATUS "
				+ "FROM FEED F JOIN MEMBER M ON(F.WRITER_NO = M.MEMBER_NO) "
				+ "WHERE F.STATUS = 'Y' AND F.NO = ? ";
		
		try {
			pstmt = connection.prepareStatement(query);
						
			pstmt.setInt(1, no); // 피드번호

			rs = pstmt.executeQuery();
		
			 
			if(rs.next()) {
				feed = new Feed();
				
				feed.setNo(rs.getInt("NO"));
				feed.setWriterId(rs.getString("NICKNAME"));
				feed.setContent(rs.getString("CONTENT"));
				feed.setOriginalFileName(rs.getString("ORIGINAL_FILENAME"));
				feed.setRenameFileName(rs.getString("RENAMED_FILENAME"));
				feed.setCreateDate(rs.getDate("CREATE_DATE"));
				feed.setStatus(rs.getString("STATUS"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}

		return feed;
	}
	
	
	
	/*최신 피드 카운트*/
	public int getRecentFeedCount(Connection connection, String pageStatus) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM FEED WHERE STATUS='Y'"; 

			
			try {
				pstmt = connection.prepareStatement(query);
			 
			rs = pstmt.executeQuery();
			
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
		return count;
	}

	
	
	/*페이지에 보여주는 최신 피드 정보 리스트*/
	public List<Feed> getRecentFeedList(Connection connection, PageInfo pageInfo, String pageStatus) {
		List<Feed> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;

		ResultSet rs = null;
		String query =
						"SELECT RNUM, NO, NICKNAME, CONTENT, RENAMED_FILENAME, CREATE_DATE, STATUS "
				+ 		"FROM (SELECT ROWNUM AS RNUM, "
				+ 		"NO, "
				+ 		"NICKNAME, "
				+ 		"CONTENT, "
				+ 		"RENAMED_FILENAME, "
				+ 		"CREATE_DATE, "
				+ 		"STATUS "
				+ 		"FROM (SELECT F.NO, "
				+ 						"M.NICKNAME, "
				+ 						"F.CONTENT, "
				+ 						"F.RENAMED_FILENAME, "
				+ 						"F.CREATE_DATE, "
				+ 						"F.STATUS "
				+ 				"FROM FEED F JOIN MEMBER M ON(F.WRITER_NO = M.MEMBER_NO) "
				+ 				"WHERE F.STATUS = 'Y' ORDER BY F.NO DESC) "
				+ 		")"
				+ 		"WHERE RNUM BETWEEN ? and ?";

			try {
				pstmt = connection.prepareStatement(query);
				
				pstmt.setInt(1, pageInfo.getStartList());
				pstmt.setInt(2, pageInfo.getEndList());	

				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					Feed feed = new Feed();				
					
					feed.setNo(rs.getInt("NO"));
					feed.setRowNum(rs.getInt("RNUM"));
					feed.setWriterId(rs.getString("NICKNAME"));
					feed.setContent(rs.getString("CONTENT"));
					feed.setRenameFileName(rs.getString("RENAMED_FILENAME"));
					feed.setCreateDate(rs.getDate("CREATE_DATE"));
					feed.setStatus(rs.getString("STATUS"));
					feed.setReplies(this.getFeedReplies(connection, rs.getInt("NO")));
					
					list.add(feed);
					
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
		return list;
	}



	/*내가 작성한 피드 카운트*/
	public int getMypageFeedCount(Connection connection, String pageStatus, Member loginMember) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = " SELECT COUNT(CASE WHEN WRITER_NO = ?  THEN 1 END)  FROM FEED  WHERE STATUS='Y' ";			
		
			
			try {
				pstmt = connection.prepareStatement(query);
				
				pstmt.setInt(1, loginMember.getMemberNo()); //로그인 회원 번호		
			 
				rs = pstmt.executeQuery();
			
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
		return count;
	}
	
	
	
	/*페이지에 보여주는 내가 작성한 피드 정보 리스트*/
	public List<Feed> getMypageFeedList(Connection connection, PageInfo pageInfo, String pageStatus, Member loginMember) {
		List<Feed> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = 	
						"SELECT RNUM, NO, NICKNAME, CONTENT, RENAMED_FILENAME, CREATE_DATE, STATUS "
				+ 		"FROM (SELECT ROWNUM AS RNUM, "
				+ 		"NO, "
				+ 		"NICKNAME, "
				+ 		"CONTENT, "
				+ 		"RENAMED_FILENAME, "
				+ 		"CREATE_DATE, "
				+ 		"STATUS "
				+ 		"FROM (SELECT F.NO, "
				+ 						"M.NICKNAME, "
				+ 						"F.CONTENT, "
				+ 						"F.RENAMED_FILENAME, "
				+ 						"F.CREATE_DATE, "
				+ 						"F.STATUS "
				+ 				"FROM FEED F JOIN MEMBER M ON(F.WRITER_NO = M.MEMBER_NO) "
				+ 				"WHERE F.STATUS = 'Y' AND F.WRITER_NO= ? ORDER BY F.NO DESC) "
				+ 		")"
				+ 		"WHERE RNUM BETWEEN ? and ?";

			
			try {
				pstmt = connection.prepareStatement(query);
				
				pstmt.setInt(1, loginMember.getMemberNo()); //로그인 회원 번호
				pstmt.setInt(2, pageInfo.getStartList());
				pstmt.setInt(3, pageInfo.getEndList());	

				rs = pstmt.executeQuery();

				
				while (rs.next()) {
					Feed feed = new Feed();				
					
					feed.setNo(rs.getInt("NO"));
					feed.setRowNum(rs.getInt("RNUM"));
					feed.setWriterId(rs.getString("NICKNAME"));
					feed.setContent(rs.getString("CONTENT"));
					feed.setRenameFileName(rs.getString("RENAMED_FILENAME"));
					feed.setCreateDate(rs.getDate("CREATE_DATE"));
					feed.setStatus(rs.getString("STATUS"));
					feed.setReplies(this.getFeedReplies(connection, rs.getInt("NO")));
					
					list.add(feed);
					
				}
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
		return list;
	}
	

	
	/*추천 피드 카운트*/
	public int getRecommendeFeedCount(Connection connection, String pageStatus, Member loginMember) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = " SELECT COUNT(CASE WHEN REGEXP_LIKE(INTEREST, ?) THEN 1 END)  FROM FEED  WHERE STATUS='Y' ";			
			
			try {
				pstmt = connection.prepareStatement(query);
				
				pstmt.setString(1, loginMember.getInterest().replaceAll(",","|")); 	
			 
				rs = pstmt.executeQuery();
			
				if(rs.next()) {
					count = rs.getInt(1);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
		return count;
	}

	
	
	/*페이지에 보여주는 내가 추천 피드 정보 리스트*/
	public List<Feed> getRecommendeFeedList(Connection connection, PageInfo pageInfo, String pageStatus, Member loginMember) {
		List<Feed> list = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query =
						"SELECT RNUM, NO, NICKNAME, CONTENT, RENAMED_FILENAME, CREATE_DATE, STATUS "
				+ 		"FROM (SELECT ROWNUM AS RNUM, "
				+ 		"NO, "
				+ 		"NICKNAME, "
				+ 		"CONTENT, "
				+ 		"RENAMED_FILENAME, "
				+ 		"CREATE_DATE, "
				+ 		"STATUS "
				+ 		"FROM (SELECT F.NO, "
				+ 						"M.NICKNAME, "
				+ 						"F.CONTENT, "
				+ 						"F.RENAMED_FILENAME, "
				+ 						"F.CREATE_DATE, "
				+ 						"F.STATUS "
				+ 				"FROM FEED F JOIN MEMBER M ON(F.WRITER_NO = M.MEMBER_NO) "
				+ 				"WHERE F.STATUS = 'Y' AND REGEXP_LIKE(F.INTEREST, ?) ORDER BY F.NO DESC) "
				+ 		")"
				+ 		"WHERE RNUM BETWEEN ? and ?";

			try {
				pstmt = connection.prepareStatement(query);
				
				pstmt.setString(1, loginMember.getInterest().replaceAll(",","|"));
				pstmt.setInt(2, pageInfo.getStartList());
				pstmt.setInt(3, pageInfo.getEndList());	
				
				rs = pstmt.executeQuery();
				
				while (rs.next()) {
					Feed feed = new Feed();				
					
					feed.setNo(rs.getInt("NO"));
					feed.setRowNum(rs.getInt("RNUM"));
					feed.setWriterId(rs.getString("NICKNAME"));
					feed.setContent(rs.getString("CONTENT"));
					feed.setRenameFileName(rs.getString("RENAMED_FILENAME"));
					feed.setCreateDate(rs.getDate("CREATE_DATE"));
					feed.setStatus(rs.getString("STATUS"));
					feed.setReplies(this.getFeedReplies(connection, rs.getInt("NO")));
					
					list.add(feed);
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				close(rs);
				close(pstmt);
			}
		return list;
	}



	/*해당 게시물의 댓글 정보*/
	public List<Replies> getFeedReplies(Connection connection, int feed_no) {
		List<Replies> replylist = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = null;
		
		query = 
				"SELECT R.NO, R.FEED_NO, R.CONTENT, M.NICKNAME, M.MEMBER_NO, R.CREATE_DATE, R.MODIFY_DATE "
			+	"FROM FEED_REPLIES R "
			+	"JOIN MEMBER M ON(R.WRITER_NO = M.MEMBER_NO) "
			+	"WHERE R.STATUS='Y' AND FEED_NO= ? "
			+	"ORDER BY R.NO DESC ";

		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, feed_no); //로그인 회원 번호

			rs = pstmt.executeQuery();	
			
			while (rs.next()) {
				Replies reply = new Replies();
					
				reply.setNo(rs.getInt("NO"));
				reply.setFeed_no(rs.getInt("FEED_NO"));
				reply.setContent(rs.getString("CONTENT"));
				reply.setWriter_id(rs.getString("NICKNAME"));
				reply.setWriter_no(rs.getInt("MEMBER_NO"));
				reply.setCreateDate(rs.getDate("CREATE_DATE"));
				reply.setModifyDate(rs.getDate("MODIFY_DATE"));
					
					replylist.add(reply);
				}
			
		}  catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		return replylist;
	}
	
	
	
	/*게시물 등록*/
	public int insertfeed(Connection connection, Feed feed) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO FEED VALUES(SEQ_FEED_NO.NEXTVAL,?,?,?,?,?,DEFAULT,DEFAULT,DEFAULT)"; 
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, feed.getWriterNo());
			pstmt.setString(2, feed.getContent());
			pstmt.setString(3, feed.getInterest());
			pstmt.setString(4, feed.getOriginalFileName());
			pstmt.setString(5, feed.getRenameFileName());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	
	
	
	/*댓글 등록*/
	public int insertfeed_Replies(Connection connection, Replies replies) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO FEED_REPLIES VALUES(SEQ_REPLIES_NO.NEXTVAL, ?, ?, ?, DEFAULT, DEFAULT, DEFAULT)"; 
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, replies.getFeed_no());
			pstmt.setInt(2, replies.getWriter_no());
			pstmt.setString(3, replies.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	

	/*게시글 수정*/
	public int upDatafeed(Connection connection, Feed feed) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE FEED SET CONTENT=?,ORIGINAL_FILENAME=?,RENAMED_FILENAME=?,MODIFY_DATE=SYSDATE WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, feed.getContent());
			pstmt.setString(2, feed.getOriginalFileName());
			pstmt.setString(3, feed.getRenameFileName());
			pstmt.setInt(4, feed.getNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	

	/*게시글 상태 변경(삭제)*/
	public int updateStatus(Connection connection, int no, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE FEED SET STATUS=? WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, status);
			pstmt.setInt(2, no);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}


	
	/*댓글 상태 변경(삭제)*/
	public int repliesStatus(Connection connection, int no, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE FEED_REPLIES SET STATUS=? WHERE NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, status);
			pstmt.setInt(2, no);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}

		return result;
	}















	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
