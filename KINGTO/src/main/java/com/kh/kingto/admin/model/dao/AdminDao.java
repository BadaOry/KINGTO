package com.kh.kingto.admin.model.dao;

import static com.kh.kingto.common.jdbc.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import com.kh.kingto.admin.model.vo.Report;

public class AdminDao {

	public int report(Connection connection, Report report) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO REPORT VALUES(SEQ_REPORT_NO, DEFAULT, ?, ?, ?, ?)"; // 
		
		try {
			pstmt = connection.prepareStatement(query);
			
			// 물음표에 차례로 신고한사람, 신고당한사람, 신고피드 번호, 신고내용 넣어주면 됨
//			pstmt.setString(1,userPwd);
//			pstmt.setInt(2, memberNo);
			
			result = pstmt.executeUpdate();			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

}
