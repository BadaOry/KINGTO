package com.kh.kingto.group.model.service;

import java.sql.Connection;
import java.util.List;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.group.model.dao.GroupDao;
import com.kh.kingto.group.model.vo.GroupList;

public class GroupService {


    private GroupDao dao = new GroupDao(); 

    public int getGroupCount() {
        int count = 0;
        Connection connection = getConnection();

        count = dao.getGroupCount(connection);

        close(connection);

        return count;
    }

    
    public List<GroupList> getGroupList(PageInfo pageInfo) {
        List<GroupList> list = null;
        Connection connection = getConnection();

        list = dao.findAll(connection, pageInfo);

        close(connection);


        return list;
    }

    public List<GroupList> getPopularGroupList(PageInfo pageInfo) {
        List<GroupList> list = null;
        Connection connection = getConnection();

        list = dao.PopularGroupList(connection, pageInfo);

        close(connection);


        return list;
    }

	public GroupList findGroupNo(int no) {
		GroupList groupList = null;
		
		Connection connection = getConnection();
		
		groupList = dao.findGroupNo(connection, no);
		
		close(connection);
		
		return groupList;
	}

	// 소모임 번호로 소모임 조회
	public GroupList findGroup(int no) {
		GroupList groupList = null;
		
		Connection connection = getConnection();
		
		groupList = dao.findGroup(connection, no);
		
		close(connection);
		
		return groupList;


	}

	public List<GroupList> getRecectGroupList(PageInfo recectPageInfo) {
		List<GroupList> list = null;
		Connection connection = getConnection();
		
		list = dao.getRecectGroupList(connection, recectPageInfo);
		
		close(connection);
		
		
		return list;
	}

	

	// 회원번호로 가입된 소모임 개수 조회
	public int getMyGroupCount(int loginMember) {
		int count = 0;
		Connection connection = getConnection();
		
		count = dao.getMyGroupCount(connection,loginMember);
		
		close(connection);
		
		return count;
	}

	// 회원번호로 가입된 소모임 리스트 조회
	public List<GroupList> getMyGroupList(PageInfo pageInfo,int loginMember) {
		List<GroupList> list = null;
		Connection connection = getConnection();
		
		list = dao.getMyGroupList(connection, pageInfo, loginMember);
		
		close(connection);
		
		
		return list;
	}


	// 소모임 생성 (INSERT)
	public int createGroup(GroupList groupList) {
		int result = 0;
		Connection connection = getConnection();
		
		result = dao.createGroup(connection, groupList);
		
		close(connection);
		
		return result;
	}

}

