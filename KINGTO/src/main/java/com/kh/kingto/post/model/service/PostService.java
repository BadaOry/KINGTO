package com.kh.kingto.post.model.service;

import java.sql.Connection;
import java.util.List;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

import com.kh.kingto.common.util.PageInfo;

import com.kh.kingto.group.model.vo.GroupList;
import com.kh.kingto.post.model.dao.PostDao;
import com.kh.kingto.post.model.vo.PostList;

public class PostService {

	private PostDao dao = new PostDao(); 
	
	public int getPostCount() {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getPostCount(connection);
		
		close(connection);
		
		return count;
	}

	public List<PostList> getPostList(PageInfo pageInfo) {
		List<PostList> list = null;
		Connection connection = getConnection();
		
		list = dao.findAll(connection, pageInfo);
		
		close(connection);
		
		
		return list;
	}

	public int save(PostList post) {
		int result = 0;
		Connection connection = getConnection();
		
		
		result = dao.insertNotice(connection, post);
		
		
		if(result > 0) {
			commit(connection);
		}else {
			rollback(connection);
		}
		
		close(connection);
		
		
		return result;
	}


}
