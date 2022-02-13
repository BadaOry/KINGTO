package com.kh.kingto.notice.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.notice.model.vo.Notice;

public class NoticeDao extends Notice {

	public int getBoardCount(Connection conn) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM NOTICE WHERE STATUS='Y'";
		
		try {
			pstmt = conn.prepareStatement(query);
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
	
	public List<Notice> getNotice(Connection conn, int no) {
		List<Notice> npNotice = new ArrayList<>();
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		String query = "SELECT NEXT_NO, NEXT_TITLE, PREV_NO, PREV_TITLE "
				+ "FROM ( "
				+ "    SELECT "
				+ "        NO, "
				+ "        TITLE, "
				+ "        STATUS, "
				+ "        LEAD(NO, 1) OVER (ORDER BY NO DESC) AS NEXT_NO, "
				+ "        LEAD(TITLE, 1, '다음글이 없습니다') OVER (ORDER BY NO DESC) AS NEXT_TITLE, "
				+ "        LAG(NO, 1) OVER (ORDER BY NO DESC) AS PREV_NO, "
				+ "        LAG(TITLE, 1, '이전글이 없습니다') OVER (ORDER BY NO DESC) AS PREV_TITLE "
				+ "    FROM NOTICE "
				+ "    WHERE STATUS = 'Y' "
				+ ")  "
				+ "WHERE NO = ? ;";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Notice notice = new Notice();
				
				
				notice.setPrevNo(rs.getInt("PREV_NO"));
				notice.setPrevTitle(rs.getString("PREV_TITLE"));
				notice.setNextNo(rs.getInt("NEXT_NO"));
				notice.setNextTitle(rs.getString("NEXT_TITLE"));
				
				npNotice.add(notice);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return npNotice;
	}
	
	
	
	public List<Notice> findAll(Connection conn, PageInfo pageInfo) {
		List<Notice> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = 
				"SELECT RNUM, NOTICE_NO, TITLE, ID, CREATE_DATE, READCOUNT, STATUS "
						+ "FROM ("
						+    "SELECT ROWNUM AS RNUM, "
						+           "NOTICE_NO, "
						+ 			"TITLE, "
						+ 			"ID, "
						+ 			"CREATE_DATE, "
						+  			"READCOUNT, "
						+     		"STATUS "
						+ 	 "FROM ("
						+ 	    "SELECT N.NOTICE_NO, "
						+ 			   "N.TITLE, "
						+  			   "M.ID, "
						+ 			   "N.CREATE_DATE, "
						+ 			   "N.READCOUNT, "
						+ 	   		   "N.STATUS "
						+ 		"FROM NOTICE N "
						+ 		"JOIN MEMBER M ON(N.WRITER_NO = M.MEMBER_NO) "
						+ 		"WHERE N.STATUS = 'Y' ORDER BY N.NOTICE_NO DESC"
						+ 	 ")"
						+ ") WHERE RNUM BETWEEN ? and ?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Notice notice = new Notice();
				
				notice.setNo(rs.getInt("NOTICE_NO"));
				notice.setRowNum(rs.getInt("RNUM"));
				notice.setWriterId(rs.getString("ID"));
				notice.setTitle(rs.getString("TITLE"));
				notice.setCreatedDate(rs.getDate("CREATE_DATE"));
				notice.setReadCount(rs.getInt("READCOUNT"));
				notice.setStatus(rs.getString("STATUS"));
				
				list.add(notice);
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	
	public int insertNotice(Connection connection, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO NOTICE VALUES(SEQ_NOTICE_NO.NEXTVAL,?,?,?,DEFAULT,DEFAULT,DEFAULT,DEFAULT)";
		

		
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, notice.getWriterNo());
//			pstmt.setInt(1, 1);
			pstmt.setString(2, notice.getTitle());
			pstmt.setString(3, notice.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}

	public Notice findNoticeByNo(Connection conn, int no) {
		Notice notice = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = 
				"SELECT  "
				+ "N.NOTICE_NO, N.TITLE, "
				+ "M.ID, N.READCOUNT, "
				+ "N.CONTENT, "
				+ "N.CREATE_DATE, "
				+ "N.MODIFY_DATE, "
				+ "N.PREV_NO, N.PREV_TITLE, "
				+ "N.NEXT_NO, N.NEXT_TITLE "
				+ "FROM ( "
				+ "    SELECT "
				+ "        NOTICE_NO, "
				+ "        TITLE, "
				+ "        STATUS, "
				+ "        WRITER_NO, "
				+ "        CONTENT, "
				+ "        READCOUNT, "
				+ "        CREATE_DATE, "
				+ "        MODIFY_DATE, "
				+ "        LEAD(NOTICE_NO, 1, 0) OVER ( ORDER BY NOTICE_NO DESC) AS NEXT_NO, "
				+ "        LEAD(TITLE, 1, '다음글이 없습니다') OVER ( ORDER BY NOTICE_NO DESC) AS NEXT_TITLE, "
				+ "        LAG(NOTICE_NO, 1, 0) OVER ( ORDER BY NOTICE_NO DESC) AS PREV_NO, "
				+ "        LAG(TITLE, 1, '이전글이 없습니다') OVER ( ORDER BY NOTICE_NO DESC) AS PREV_TITLE "
				+ "    FROM NOTICE "
				+ "    WHERE STATUS = 'Y' "
				+ ") N "
				+ "JOIN MEMBER M ON(N.WRITER_NO = M.MEMBER_NO) "
				+ "WHERE N.STATUS = 'Y' AND N.NOTICE_NO=?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				notice = new Notice();
				
				notice.setNo(rs.getInt("NOTICE_NO"));
				notice.setTitle(rs.getString("TITLE"));
				notice.setWriterId(rs.getString("ID"));
				notice.setReadCount(rs.getInt("READCOUNT"));
				notice.setContent(rs.getString("CONTENT"));
				notice.setCreatedDate(rs.getDate("CREATE_DATE"));
				notice.setModifyDate(rs.getDate("MODIFY_DATE"));
				notice.setPrevNo(rs.getInt("PREV_NO"));
				notice.setPrevTitle(rs.getString("PREV_TITLE"));
				notice.setNextNo(rs.getInt("NEXT_NO"));
				notice.setNextTitle(rs.getString("NEXT_TITLE"));
				
			}
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return notice;
	}
	
	public int updateNotice(Connection connection, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE NOTICE SET TITLE=?,CONTENT=?,MODIFY_DATE=SYSDATE WHERE NOTICE_NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, notice.getTitle());
			pstmt.setString(2, notice.getContent());
			pstmt.setInt(3, notice.getNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}
	
	public int updateStatus(Connection connection, int no, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE NOTICE SET STATUS=? WHERE NOTICE_NO=?";
		
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

	public int updateReadCount(Connection conn, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE NOTICE SET READCOUNT=? WHERE NOTICE_NO=?";
		
		try {
			pstmt = conn.prepareStatement(query);
			
			notice.setReadCount(notice.getReadCount() + 1);
			
			pstmt.setInt(1, notice.getReadCount());
			pstmt.setInt(2, notice.getNo());
			
			result = pstmt.executeUpdate();			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}		
		
		return result;
		
		
	}
	

	


}
