package com.kh.kingto.post.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.group.model.vo.GroupList;
import com.kh.kingto.post.model.vo.PostList;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

public class PostDao {

		public int getPostCount(Connection connection) {
			int count = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String query ="SELECT COUNT(*) FROM POST WHERE POST_STATUS ='Y'";
		
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

	public List<PostList> findAll(Connection connection, PageInfo pageInfo) {
		List<PostList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT RNUM, POST_NO, POST_TITLE, POST_SGROUP_NO, ID, POST_CREATE, POST_LIKE, POST_READCOUNT, POST_STATUS "
				+ "FROM ("
				+    "SELECT ROWNUM AS RNUM, "
				+           "POST_NO, "
				+ 			"POST_TITLE, "
                + 			"POST_SGROUP_NO, "
				+ 			"ID, "
				+ 			"POST_CREATE, "
				+ 			"POST_LIKE, "
				+  			"POST_READCOUNT, "
				+     		"POST_STATUS "
				+ 	 "FROM ("
				+ 	    "SELECT P.POST_NO, "
				+ 			   "P.POST_TITLE, "
                +  			   "P.POST_SGROUP_NO, "
				+  			   "M.ID, "
				+ 			   "P.POST_CREATE, "
				+ 			   "P.POST_LIKE, "
				+ 			   "P.POST_READCOUNT, "
				+ 	   		   "P.POST_STATUS "
				+ 		"FROM POST P "
				+ 		"JOIN MEMBER M ON(P.POST_MEMBER = M.MEMBER_NO) "
                + 		"JOIN SGROUP S ON(P.POST_SGROUP_NO = S.SGROUP_NO) "
				+ 		"WHERE P.POST_STATUS = 'Y' ORDER BY P.POST_NO DESC"
				+ 	 ")"
				+ ") WHERE RNUM BETWEEN ? and ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				PostList postList = new PostList();
				
				postList.setPost_no(rs.getInt("POST_NO"));
				postList.setRowNum(rs.getInt("RNUM"));
				postList.setPost_title(rs.getString("POST_TITLE"));
				postList.setPost_sgroup_no(rs.getInt("POST_SGROUP_NO"));
				postList.setPost_id(rs.getString("ID"));
				postList.setPost_like(rs.getString("POST_LIKE"));
				postList.setPost_create(rs.getDate("POST_CREATE"));
				postList.setPost_like(rs.getString("POST_LIKE"));
				postList.setPost_readcount(rs.getInt("POST_READCOUNT"));
				postList.setPost_status(rs.getString("POST_STATUS"));
				
				list.add(postList);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int insertNotice(Connection connection, PostList post) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO POST VALUES(SEQ_POST_NO.NEXTVAL,?,?,?,?,DEFAULT,DEFAULT,DEFAULT,DEFAULT,DEFAULT)";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, post.getPost_sgroup_no()); // 소모임 번호
			pstmt.setInt(2, post.getPost_member()); // 회원 번호
			pstmt.setString(3, post.getPost_title()); // 제목
			pstmt.setString(3, post.getPost_cont()); // 내용
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}
}
