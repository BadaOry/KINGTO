package com.kh.kingto.member.model.dao;


import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import java.util.ArrayList;
import java.util.List;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.friends.model.vo.FriendsPageInfo;
import com.kh.kingto.member.model.vo.Member;


public class MemberDao {

	public int insertMember(Connection connection, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO MEMBER VALUES(SEQ_UNO.NEXTVAL, DEFAULT, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, DEFAULT, DEFAULT, ?)";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, member.getMemberRole());
			
			pstmt.setString(2, member.getInterest());
			pstmt.setInt(3, member.getNatCode());
			
			pstmt.setInt(4, member.getLcOne());
			pstmt.setInt(5, member.getLcOneLv());
			
			pstmt.setInt(6, member.getLocalCode());
			
			pstmt.setString(7, member.getId());
			pstmt.setString(8, member.getPwd());
			pstmt.setString(9, member.getEmail());
			pstmt.setString(10, member.getNickname());
			
			pstmt.setInt(11, member.getLcTwo());
			pstmt.setInt(12, member.getLcTwoLv());
			pstmt.setInt(13, member.getLcThr());
			pstmt.setInt(14, member.getLcThrLv());
			
			pstmt.setString(15, member.getOriginalFilename());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
	



	public Member findMemberById(Connection connection, String userId) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM MEMBER WHERE ID=? AND MEMBER_STATUS='Y' ";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, userId);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new Member();
				
				member.setMemberNo(rs.getInt("MEMBER_NO"));
				member.setMemberRole(rs.getString("MEMBER_ROLE"));
				member.setNatCode(rs.getInt("NAT_CODE"));
				member.setLcOne(rs.getInt("LC_ONE"));
				member.setLcOneLv(rs.getInt("LC_ONE_LV"));
				member.setLocalCode(rs.getInt("LOCAL_CODE"));
				member.setInterest(rs.getString("INTEREST"));
				member.setId(rs.getString("ID"));
				member.setPwd(rs.getString("PWD"));
				member.setEmail(rs.getString("EMAIL"));
				member.setNickname(rs.getString("NICKNAME"));
				member.setLcTwo(rs.getInt("LC_TWO"));
				member.setLcTwoLv(rs.getInt("LC_TWO_LV"));
				member.setLcThr(rs.getInt("LC_THR"));
				member.setLcThrLv(rs.getInt("LC_THR_LV"));
				member.setEnrollDate(rs.getDate("ENROLL_DATE"));
				member.setModifyDate(rs.getDate("MODIFY_DATE"));
				member.setOriginalFilename(rs.getString("ORIGINAL_FILENAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return member;
	}


	public int updateMember(Connection connection, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE MEMBER SET INTEREST=?, LOCAL_CODE=?, EMAIL=?, NICKNAME=?, LC_TWO=?,LC_TWO_LV=?, LC_THR=?, LC_THR_LV=?, MODIFY_DATE=DEFAULT, ORIGINAL_FILENAME=? WHERE MEMBER_NO=?";
	
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, member.getInterest());
			pstmt.setInt(2, member.getLocalCode());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getNickname());
			
			pstmt.setInt(5, member.getLcTwo());
			pstmt.setInt(6, member.getLcTwoLv());
			pstmt.setInt(7, member.getLcThr());
			pstmt.setInt(8, member.getLcThrLv());
			
			pstmt.setString(9, member.getOriginalFilename());
			
			pstmt.setInt(10, member.getMemberNo());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}




	public Member findMemberByNickname(Connection connection, String userNickname) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT * FROM MEMBER WHERE NICKNAME=? AND MEMBER_STATUS='Y' ";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, userNickname);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new Member();
				
				member.setMemberNo(rs.getInt("MEMBER_NO"));
				member.setMemberRole(rs.getString("MEMBER_ROLE"));
				member.setNatCode(rs.getInt("NAT_CODE"));
				member.setLcOne(rs.getInt("LC_ONE"));
				member.setLcOneLv(rs.getInt("LC_ONE_LV"));
				member.setLocalCode(rs.getInt("LOCAL_CODE"));
				member.setInterest(rs.getString("INTEREST"));
				member.setId(rs.getString("ID"));
				member.setPwd(rs.getString("PWD"));
				member.setEmail(rs.getString("EMAIL"));
				member.setNickname(rs.getString("NICKNAME"));
				member.setLcTwo(rs.getInt("LC_TWO"));
				member.setLcTwoLv(rs.getInt("LC_TWO_LV"));
				member.setLcThr(rs.getInt("LC_THR"));
				member.setLcThrLv(rs.getInt("LC_THR_LV"));
				member.setEnrollDate(rs.getDate("ENROLL_DATE"));
				member.setModifyDate(rs.getDate("MODIFY_DATE"));
				member.setOriginalFilename(rs.getString("ORIGINAL_FILENAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return member;
	}
	


	public int saveProfile(Connection connection, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "INSERT INTO MEMBER ";	
		
		return result;
	}



	public int updateMemberPassword(Connection connection, int memberNo, String userPwd) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "UPDATE MEMBER SET PWD=? WHERE MEMBER_NO=?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1,userPwd);
			pstmt.setInt(2, memberNo);
			
			result = pstmt.executeUpdate();			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}


	public int updateMemberStatus(Connection connection, int memberNo, String status) {
		int result = 0;
		PreparedStatement pstmt = null;
		// ▼ 탈퇴하는 회원의 아이디와 닉네임을 지워주는 쿼리문
		String query = "UPDATE MEMBER SET MEMBER_STATUS=?,NICKNAME=SEQ_DELETE.NEXTVAL,ID=SEQ_DELETE.NEXTVAL WHERE MEMBER_NO=?";

		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, status);
			pstmt.setInt(2, memberNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}




	// DB에서 전체 회원 수 얻어오는 메소드
	public int getMemberCount(Connection connection) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT COUNT(*) FROM MEMBER WHERE MEMBER_STATUS='Y'";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
				
//				System.out.println("COUNT(*) : " + count);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
	}
	
	// 현재 페이지에 표시할 멤버 리스트 조회해오는 메소드
	public List<Member> findAll(Connection connection, FriendsPageInfo pageInfo) {
		List<Member> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query = "SELECT RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME, LC_TWO, LC_TWO_LV "
				+ "FROM( "
				+ "    SELECT ROWNUM AS RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME, LC_TWO, LC_TWO_LV "
				+ "    FROM MEMBER "
				+ "    JOIN LANGUAGE ON(LC_ONE = LANG_CODE) "
				+ "    JOIN NATIONALITY USING(NAT_CODE) "
				+ "    WHERE MEMBER_STATUS='Y' "
				+ "    ) "
				+ "WHERE RNUM BETWEEN ? AND ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, pageInfo.getStartList());
			pstmt.setInt(2, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				
//				System.out.println("pageInfo.getStartList() : " + pageInfo.getStartList());
//				System.out.println("pageInfo.getEndList() : " + pageInfo.getEndList());
				
				
				
				Member member = new Member();
				
				member.setMemberNo(rs.getInt("MEMBER_NO"));
				member.setRowNum(rs.getInt("RNUM"));
				member.setNatCode(rs.getInt("NAT_CODE"));
				member.setLcOne(rs.getInt("LC_ONE"));
				member.setLcOneLv(rs.getInt("LC_ONE_LV"));
				member.setLocalCode(rs.getInt("LOCAL_CODE"));
				member.setInterest(rs.getString("INTEREST"));
				member.setNickname(rs.getString("NICKNAME"));
				member.setOriginalFilename(rs.getString("ORIGINAL_FILENAME"));
				member.setLangName(rs.getString("LANG_NAME"));
				member.setNatName(rs.getString("NAT_NAME"));
				member.setLcTwo(rs.getInt("LC_TWO"));
				member.setLcTwoLv(rs.getInt("LC_TWO_LV"));
				
				list.add(member);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return list;
	}
	
	// DB에서 회원 번호를 통해 회원 조회해오는 메소드
	public Member findMemberByNo(Connection connection, int no) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String query ="SELECT MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME, LC_TWO, LC_TWO_LV  "
				+ "FROM MEMBER "
				+ "JOIN LANGUAGE ON(LC_ONE = LANG_CODE) "
				+ "JOIN NATIONALITY USING(NAT_CODE) "
				+ "WHERE MEMBER_NO=? AND MEMBER_STATUS='Y'";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new Member();
				
				member.setMemberNo(no);
				member.setMemberStatus(rs.getString("MEMBER_STATUS").charAt(0));
				member.setNatCode(rs.getInt("NAT_CODE"));
				member.setLcOne(rs.getInt("LC_ONE"));
				member.setLcOneLv(rs.getInt("LC_ONE_LV"));
				member.setLocalCode(rs.getInt("LOCAL_CODE"));
				member.setInterest(rs.getString("INTEREST"));
				member.setNickname(rs.getString("NICKNAME"));
				member.setOriginalFilename(rs.getString("ORIGINAL_FILENAME"));
				member.setLangName(rs.getString("LANG_NAME"));
				member.setNatName(rs.getString("NAT_NAME"));
				member.setLcTwo(rs.getInt("LC_TWO"));
				member.setLcTwoLv(rs.getInt("LC_TWO_LV"));
				
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		return member;
		}




	// 언어 코드로 배우고 싶은 언어 이름 받아오기
	public String getLangName(Connection connection, Member member) {
		String name = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT LANG_NAME "
				+ "FROM MEMBER "
				+ "JOIN LANGUAGE ON (LC_TWO = LANG_CODE) "
				+ "WHERE MEMBER_NO = ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, member.getMemberNo());
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				name = rs.getString("LANG_NAME");
			}
					
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		
		
		return name;
	}
}