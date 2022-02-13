package com.kh.kingto.admin.model.service;

import static com.kh.kingto.common.jdbc.JDBCTemplate.close;
import static com.kh.kingto.common.jdbc.JDBCTemplate.commit;
import static com.kh.kingto.common.jdbc.JDBCTemplate.getConnection;
import static com.kh.kingto.common.jdbc.JDBCTemplate.rollback;

import java.sql.Connection;

import com.kh.kingto.admin.model.dao.AdminDao;
import com.kh.kingto.admin.model.vo.Report;


public class AdminService {

	public int save(Report report) {
		int result = 0;
		Connection connection = getConnection();
		
		result = new AdminDao().report(connection, report);
		
		if(result > 0) {
			commit(connection);
		} else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}

}
