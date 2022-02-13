package com.kh.kingto.group.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.group.model.vo.GroupList;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

public class GroupDao {


	public int getGroupCount(Connection connection) {
			int count = 0;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			String query ="SELECT COUNT(*) FROM SGROUP WHERE SGROUP_OPEN ='Y'";
		
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

	public List<GroupList> findAll(Connection connection, PageInfo pageInfo) {
		List<GroupList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_INTRODUCE, SGROUP_IMG "
				+ "FROM ("
				+    "SELECT ROWNUM AS RNUM, "
				+           "SGROUP_NO, "
				+ 			"SGROUP_NAME, "
                + 			"ID, "
				+ 			"MEMBER_NO, "
				+ 			"SGROUP_OPEN, "
                + 			"INTEREST, "
				+ 			"SGROUP_INTRODUCE, "
				+  			"SGROUP_IMG "
				+ 	 "FROM ("
				+ 	    "SELECT S.SGROUP_NO, "
				+ 			   "S.SGROUP_NAME, "
                + 			   "M.ID, "
				+  			   "M.MEMBER_NO, "
				+ 			   "S.SGROUP_OPEN, "
                + 			   "M.INTEREST, "
				+ 			   "S.SGROUP_INTRODUCE, "
				+ 			   "S.SGROUP_IMG "
				+ 		"FROM SGROUP S "
				+ 		"JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO) "
				+ 		"WHERE S.SGROUP_OPEN = 'Y' ORDER BY S.SGROUP_NO DESC"
				+ 	 ")"
				+ ") WHERE RNUM BETWEEN ? and ?";
				
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GroupList groupList = new GroupList();
				
				groupList.setSgroup_no(rs.getInt("SGROUP_NO"));
				groupList.setRowNum(rs.getInt("RNUM"));
				groupList.setSgroup_name(rs.getNString("SGROUP_NAME"));
				groupList.setSgroup_admin(rs.getInt("MEMBER_NO"));
				groupList.setId(rs.getString("ID"));
				groupList.setSgroup_open(rs.getString("SGROUP_OPEN"));
				groupList.setSgroup_introduce(rs.getString("SGROUP_INTRODUCE"));
				groupList.setSgroup_img(rs.getString("SGROUP_IMG"));
				
				list.add(groupList);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	
	public GroupList findGroupNo(Connection connection, int no) {
		GroupList groupList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT  S.SGROUP_NO, S.SGROUP_NAME, M.ID, S.SGROUP_OPEN, M.INTEREST, S.SGROUP_INTRODUCE, S.SGROUP_IMG, SGROUP_MEMBERCOUNT "
				+ "FROM SGROUP S JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO) "
				+ "LEFT OUTER JOIN (SELECT SMEMBER_NO, COUNT(SMEMBER_NO) AS SGROUP_MEMBERCOUNT FROM SGROUP_MEMBER GROUP BY SMEMBER_NO ) C ON (S.SGROUP_NO = C.SMEMBER_NO) "
				+ "WHERE S.SGROUP_OPEN = 'Y' AND S.SGROUP_NO = ? ";
		
		try {
			pstmt = connection.prepareStatement(query);
            
            pstmt.setInt(1, no);

//            System.out.println(no);
            
            rs = pstmt.executeQuery();
            
           if(rs.next()) {
                groupList = new GroupList();
                
                groupList.setSgroup_no(rs.getInt("SGROUP_NO"));
                groupList.setSgroup_name(rs.getString("SGROUP_NAME"));
                groupList.setId(rs.getString("ID"));
                groupList.setSgroup_open(rs.getString("SGROUP_OPEN"));
                groupList.setSgroup_interest(rs.getString("INTEREST"));
                groupList.setSgroup_introduce(rs.getString("SGROUP_INTRODUCE"));
                groupList.setSgroup_img(rs.getString("SGROUP_IMG"));
                groupList.setSgroup_MemberCount(rs.getInt("SGROUP_MEMBERCOUNT"));
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        
        return groupList;
    }

	public GroupList findGroup(Connection connection, int no) {
		GroupList groupList = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT  S.SGROUP_NO, S.SGROUP_NAME, M.ID, S.SGROUP_OPEN, M.INTEREST, S.SGROUP_INTRODUCE, S.SGROUP_IMG, SGROUP_MEMBERCOUNT "
				+ "FROM SGROUP S JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO) "
				+ "LEFT OUTER JOIN (SELECT SMEMBER_NO, COUNT(SMEMBER_NO) AS SGROUP_MEMBERCOUNT FROM SGROUP_MEMBER GROUP BY SMEMBER_NO ) C ON (S.SGROUP_NO = C.SMEMBER_NO) "
				+ "WHERE S.SGROUP_OPEN = 'Y' AND S.SGROUP_NO = ? ";
		
		try {
			pstmt = connection.prepareStatement(query);
            
            pstmt.setInt(1, no);

//            System.out.println(no);
            
            rs = pstmt.executeQuery();
            
           if(rs.next()) {
                groupList = new GroupList();
                
                groupList.setSgroup_no(rs.getInt("SGROUP_NO"));
                groupList.setSgroup_name(rs.getString("nSGROUP_NAME"));
                groupList.setId(rs.getString("ID"));
                groupList.setSgroup_open(rs.getString("SGROUP_OPEN"));
                groupList.setSgroup_interest(rs.getString("INTEREST"));
                groupList.setSgroup_introduce(rs.getString("SGROUP_INTRODUCE"));
                groupList.setSgroup_img(rs.getString("SGROUP_IMG"));
                groupList.setSgroup_MemberCount(rs.getInt("SGROUP_MEMBERCOUNT"));
            }
           
           System.out.println(groupList.toString());
            
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            close(rs);
            close(pstmt);
        }
        
        return groupList;
    }

	public List<GroupList> PopularGroupList(Connection connection, PageInfo pageInfo) {
		List<GroupList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = 
				  "SELECT RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_IMG, SGROUP_MEMBERCOUNT "
				+ "FROM ( "
				+ "    SELECT ROWNUM AS RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_IMG, SGROUP_MEMBERCOUNT "
				+ "    FROM ( "
				+ "        SELECT S.SGROUP_NO, S.SGROUP_NAME, M.ID, M.MEMBER_NO, S.SGROUP_OPEN, M.INTEREST, S.SGROUP_INTRODUCE, S.SGROUP_IMG, C.SGROUP_MEMBERCOUNT "
				+ "        FROM SGROUP S JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO) "
				+ "            LEFT OUTER JOIN (SELECT SMEMBER_NO, COUNT(SMEMBER_NO) AS SGROUP_MEMBERCOUNT FROM SGROUP_MEMBER GROUP BY SMEMBER_NO ORDER BY SGROUP_MEMBERCOUNT DESC) C ON (S.SGROUP_NO = C.SMEMBER_NO) "
				+ "        WHERE S.SGROUP_OPEN = 'Y'  ORDER BY SGROUP_MEMBERCOUNT DESC NULLS LAST "
				+ "    ) "
				+ ") "
				+ "WHERE RNUM BETWEEN ? and ?";
				
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GroupList groupList = new GroupList();
				
				groupList.setRowNum(rs.getInt("RNUM"));
				groupList.setSgroup_no(rs.getInt("SGROUP_NO"));
				groupList.setSgroup_name(rs.getNString("SGROUP_NAME"));
				groupList.setId(rs.getString("ID"));
				groupList.setSgroup_admin(rs.getInt("MEMBER_NO"));
				groupList.setSgroup_open(rs.getString("SGROUP_OPEN"));
				groupList.setSgroup_interest(rs.getString("INTEREST"));
				groupList.setSgroup_img(rs.getString("SGROUP_IMG"));
				groupList.setSgroup_MemberCount(rs.getInt("SGROUP_MEMBERCOUNT"));
				
				list.add(groupList);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}


	public List<GroupList> getRecectGroupList(Connection connection, PageInfo recectPageInfo) {
		List<GroupList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = 
				  "SELECT RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_IMG, SGROUP_MEMBERCOUNT "
				  + "FROM ( "
				  + "    SELECT ROWNUM AS RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_IMG, SGROUP_MEMBERCOUNT "
				  + "    FROM ( "
				  + "        SELECT S.SGROUP_NO, S.SGROUP_NAME, M.ID, M.MEMBER_NO, S.SGROUP_OPEN, M.INTEREST, S.SGROUP_INTRODUCE, S.SGROUP_IMG, C.SGROUP_MEMBERCOUNT "
				  + "        FROM SGROUP S JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO) "
				  + "            LEFT OUTER JOIN (SELECT SMEMBER_NO, COUNT(SMEMBER_NO) AS SGROUP_MEMBERCOUNT FROM SGROUP_MEMBER GROUP BY SMEMBER_NO ORDER BY SGROUP_MEMBERCOUNT DESC) C ON (S.SGROUP_NO = C.SMEMBER_NO) "
				  + "        WHERE S.SGROUP_OPEN = 'Y'  ORDER BY SGROUP_NO DESC "
				  + "    ) "
				  + ") "
				  + "WHERE RNUM BETWEEN ? and ?";
				
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, recectPageInfo.getStartList());
			pstmt.setInt(2, recectPageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GroupList groupList = new GroupList();
				
				groupList.setRowNum(rs.getInt("RNUM"));
				groupList.setSgroup_no(rs.getInt("SGROUP_NO"));
				groupList.setSgroup_name(rs.getNString("SGROUP_NAME"));
				groupList.setId(rs.getString("ID"));
				groupList.setSgroup_admin(rs.getInt("MEMBER_NO"));
				groupList.setSgroup_open(rs.getString("SGROUP_OPEN"));
				groupList.setSgroup_interest(rs.getString("INTEREST"));
				groupList.setSgroup_img(rs.getString("SGROUP_IMG"));
				groupList.setSgroup_MemberCount(rs.getInt("SGROUP_MEMBERCOUNT"));
				
				list.add(groupList);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	public int getMyGroupCount(Connection connection, int loginMember) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query =
				  "SELECT COUNT(*) "
				+ "FROM SGROUP S JOIN SGROUP_MEMBER M ON (S.SGROUP_NO = M.SMEMBER_NO) "
				+ "WHERE S.SGROUP_OPEN ='Y' AND M.SMEMBER_MEMBER = ?";
	
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, loginMember);
			
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

	public List<GroupList> getMyGroupList(Connection connection, PageInfo pageInfo, int loginMember) {
		List<GroupList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = 
				  "SELECT RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_IMG, SGROUP_MEMBERCOUNT "
				  + "FROM (  "
				  + "    SELECT ROWNUM AS RNUM, SGROUP_NO, SGROUP_NAME, ID, MEMBER_NO, SGROUP_OPEN, INTEREST, SGROUP_IMG, SGROUP_MEMBERCOUNT "
				  + "    FROM (  "
				  + "        SELECT S.SGROUP_NO, S.SGROUP_NAME, M.ID, M.MEMBER_NO, S.SGROUP_OPEN, M.INTEREST, S.SGROUP_INTRODUCE, S.SGROUP_IMG, SGROUP_MEMBERCOUNT "
				  + "        FROM SGROUP S JOIN MEMBER M ON(S.SGROUP_ADMIN = M.MEMBER_NO) "
				  + "            JOIN SGROUP_MEMBER C ON (S.SGROUP_NO = C.SMEMBER_NO) "
				  + "            LEFT OUTER JOIN (SELECT SMEMBER_NO, COUNT(SMEMBER_NO) AS SGROUP_MEMBERCOUNT FROM SGROUP_MEMBER GROUP BY SMEMBER_NO) C ON (S.SGROUP_NO = C.SMEMBER_NO) "
				  + "        WHERE S.SGROUP_OPEN = 'Y' AND C.SMEMBER_MEMBER = ? ORDER BY SGROUP_NO "
				  + "    ) "
				  + ") "
				  + "WHERE RNUM BETWEEN ? and ?";
				
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, loginMember);  
			pstmt.setInt(2, pageInfo.getStartList());
			pstmt.setInt(3, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				GroupList groupList = new GroupList();
				
				groupList.setRowNum(rs.getInt("RNUM"));
				groupList.setSgroup_no(rs.getInt("SGROUP_NO"));
				groupList.setSgroup_name(rs.getNString("SGROUP_NAME"));
				groupList.setId(rs.getString("ID"));
				groupList.setSgroup_admin(rs.getInt("MEMBER_NO"));
				groupList.setSgroup_open(rs.getString("SGROUP_OPEN"));
				groupList.setSgroup_interest(rs.getString("INTEREST"));
				groupList.setSgroup_img(rs.getString("SGROUP_IMG"));
				groupList.setSgroup_MemberCount(rs.getInt("SGROUP_MEMBERCOUNT"));
				
				list.add(groupList);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	// 소모임 생성 (INSERT)
	public int createGroup(Connection connection, GroupList groupList) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO SGROUP "
				+ "VALUES (SEQ_SGROUP_NO.NEXTVAL, ?, ?, DEFAULT, ?, ?, ?)";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, groupList.getSgroup_admin());
			pstmt.setString(2, groupList.getSgroup_name());
			pstmt.setString(3, groupList.getSgroup_interest());
			pstmt.setString(4, groupList.getSgroup_introduce());
			pstmt.setString(5, groupList.getSgroup_img());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}	
		
		return result;
	}

}
