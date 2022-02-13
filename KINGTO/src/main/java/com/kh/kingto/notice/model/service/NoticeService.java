package com.kh.kingto.notice.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.notice.model.dao.NoticeDao;
import com.kh.kingto.notice.model.vo.Notice;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

public class NoticeService {
	
	private NoticeDao dao = new NoticeDao();

	public int getBoardCount() {
		int count = 0;
		Connection conn = getConnection();
		
		count = dao.getBoardCount(conn);
		
		close(conn);
		
		return count;
	}
	
	public List<Notice> getNoticeList(PageInfo pageInfo) {
		List<Notice> list = null;
		Connection connection = getConnection();
		
		list = dao.findAll(connection, pageInfo);
		
		close(connection);
		
		return list;
	}
	
	public int save(Notice notice) {
		int result = 0;
		Connection connection = getConnection();
		
		if(notice.getNo() != 0) {
			result = dao.updateNotice(connection, notice);
		}else {
			result = dao.insertNotice(connection, notice);
		}
		
		
		if(result > 0) {
			commit(connection);
		}else {
			rollback(connection);
		}
		
		close(connection);
		
		
		return result;
	}

	public Notice findNoticeByNo(int no, boolean hasRead) {
		Notice notice = null;
		Connection conn = getConnection();
		
		notice = dao.findNoticeByNo(conn, no);
		
		if(notice != null && !hasRead) {
			int result = dao.updateReadCount(conn, notice);
			
			if(result > 0) {
				commit(conn);
			} else {
				rollback(conn);
			}
		}
		
		close(conn);
		
		return notice;
	}
	
	public List<Notice> getNextNotice(int no) {
		List<Notice> npNotice = null;
		Connection conn = getConnection();
		
		npNotice = dao.getNotice(conn, no);
		
		close(conn);
		
		return npNotice;
	}

	public int delete(int no) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.updateStatus(connection, no, "N");
		
		if(result > 0) {
			commit(connection);
		}else {
			rollback(connection);
		}
		
		close(connection);
		
		return result;
	}


}
