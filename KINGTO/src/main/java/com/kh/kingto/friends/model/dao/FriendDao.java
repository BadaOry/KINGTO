package com.kh.kingto.friends.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.kh.kingto.common.util.PageInfo;
import com.kh.kingto.friends.model.vo.Friend;
import com.kh.kingto.friends.model.vo.FriendsList;
import com.kh.kingto.friends.model.vo.FriendsPageInfo;
import com.kh.kingto.friends.model.vo.FriendsSearchFilter;
import com.kh.kingto.member.model.vo.Member;
import com.kh.kingto.my_page.model.vo.Feed;
import com.kh.kingto.my_page.model.vo.Replies;

import static com.kh.kingto.common.jdbc.JDBCTemplate.*;

public class FriendDao {

	// 전달받은 friend 객체로 db에 insert
	public int friendRequest(Connection connection, Friend friend) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		
		// insert 
		String query = "INSERT ALL "
				+ "    INTO FRIEND VALUES (?, ?, ?, DEFAULT, DEFAULT, DEFAULT) "
				+ "    INTO FRIEND VALUES (?, ?, DEFAULT, ?, DEFAULT, DEFAULT) "
				+ "SELECT * FROM DUAL";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, friend.getFrndOne());
			pstmt.setInt(2, friend.getFrndTwo());
			pstmt.setString(3, "Y");
			pstmt.setInt(4, friend.getFrndTwo());
			pstmt.setInt(5, friend.getFrndOne());
			pstmt.setString(6, "Y");
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 전달받은 friend 객체로 db에 update(일단은 수락만('Y'))
	public int friendConfirm(Connection connection, Friend friend) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "UPDATE FRIEND SET (FRND_ONE_STATUS, FRND_TWO_STATUS) = ( "
				+ "    SELECT FRND_ONE_STATUS, FRND_TWO_STATUS "
				+ "    FROM FRIEND "
				+ "    WHERE FRND_ONE = 1 AND FRND_TWO = 2 "
				+ ") "
				+ "WHERE (FRND_ONE = ? AND FRND_TWO = ?) OR (FRND_ONE = ? AND FRND_TWO = ?)";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, friend.getFrndOne());
			pstmt.setInt(2, friend.getFrndTwo());
			pstmt.setInt(3, friend.getFrndTwo());
			pstmt.setInt(4, friend.getFrndOne());
			
			result = pstmt.executeUpdate(); // 성공시 2
			
//			System.out.println("dao의 friendConfirm : " + result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// DB 통해 전체 친구 수 조회
	public int getFriendsCount(Connection connection, int no) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT COUNT(*) "
				+ "FROM FRIEND "
				+ "WHERE FRND_ONE_STATUS='Y' AND FRND_TWO_STATUS='Y' AND FRND_ONE = ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no); 
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
				
			}			
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
	}

	// 현재 페이지에 표시할 친구 리스트 조회해오는 메소드
	public List<FriendsList> findAll(Connection connection, FriendsPageInfo pageInfo, int no) {
		List<FriendsList> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query="SELECT RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME, LC_TWO, LC_TWO_LV "
				+ "FROM( "
				+ "    SELECT ROWNUM AS RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME, LC_TWO, LC_TWO_LV "
				+ "    FROM MEMBER "
				+ "    JOIN LANGUAGE ON(LC_ONE = LANG_CODE) "
				+ "    JOIN NATIONALITY USING(NAT_CODE) "
				+ "    WHERE MEMBER_NO IN ( "
				+ "                        SELECT FRND_TWO "
				+ "                        FROM MEMBER "
				+ "                        JOIN FRIEND ON(MEMBER_NO = FRND_ONE) "
				+ "                        WHERE FRND_ONE_STATUS = 'Y' AND FRND_TWO_STATUS = 'Y' AND FRND_ONE = ? "
				+ "    ) "
				+ "		ORDER BY MEMBER_NO "
				+ ") "
				+ "WHERE RNUM BETWEEN ? AND ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no); // 로그인멤버 no
			pstmt.setInt(2, pageInfo.getStartList());
			pstmt.setInt(3, pageInfo.getEndList()); 
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				FriendsList friends = new FriendsList();
				
				friends.setFrndTwo(rs.getInt("MEMBER_NO"));
				friends.setRowNum(rs.getInt("RNUM"));
				friends.setNickname(rs.getString("NICKNAME"));
				friends.setNatCode(rs.getInt("NAT_CODE"));
				friends.setLcOne(rs.getInt("LC_ONE"));
				friends.setLcOneLv(rs.getInt("LC_ONE_LV"));
				friends.setLocalCode(rs.getInt("LOCAL_CODE"));
				friends.setInterest(rs.getString("INTEREST")); 
				friends.setOriginalFilename(rs.getString("ORIGINAL_FILENAME")); 
				friends.setFrndStatus(rs.getString("MEMBER_STATUS"));
				friends.setLangName(rs.getString("LANG_NAME"));
				friends.setNatName(rs.getString("NAT_NAME"));
				friends.setLcTwo(rs.getInt("LC_TWO"));
				friends.setLcTwoLv(rs.getInt("LC_TWO_LV"));
				
				list.add(friends);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}
	
	// DB에서 search에 담긴 조건에 해당하는 멤버 수 조회
	public int getMemberCount(Connection connection, FriendsSearchFilter search) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		
		String query = "SELECT COUNT(*) "
				+ "FROM MEMBER "
				+ "WHERE "
				+ "    REGEXP_LIKE(LC_ONE, ?) "
				+ "    AND REGEXP_LIKE(LOCAL_CODE, ?) "
				+ "    AND REGEXP_LIKE(INTEREST, ?)";	
		
		try {
			pstmt = connection.prepareStatement(query); 			
			
			pstmt.setString(1, search.getLcOne()); 
			pstmt.setString(2, search.getLocalCode()); 
			pstmt.setString(3, search.getInterest()); 
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
				
//				System.out.println("count : " + count);
			}
		
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return count;
	}
	
	// search에 담긴 조건에 해당하는 회원 조회
	public List<Member> findFiltered(Connection connection, PageInfo pageInfo, FriendsSearchFilter search) {
		List<Member> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME, LC_TWO, LC_TWO_LV "
				+ "FROM( "
				+ "SELECT ROWNUM AS RNUM, MEMBER_NO, MEMBER_STATUS, NAT_CODE, LC_ONE, LC_ONE_LV, LOCAL_CODE, INTEREST, NICKNAME, ORIGINAL_FILENAME, LANG_NAME, NAT_NAME, LC_TWO, LC_TWO_LV "
				+ "FROM MEMBER "
				+ "JOIN LANGUAGE ON(LC_ONE = LANG_CODE) "
				+ "JOIN NATIONALITY USING(NAT_CODE) "
				+ "WHERE "
				+ "REGEXP_LIKE(LC_ONE, ?) "
				+ "    AND REGEXP_LIKE(LOCAL_CODE, ?) "
				+ "    AND REGEXP_LIKE(INTEREST, ?) "
				+ "ORDER BY MEMBER_NO "
				+ "    ) "
				+ "WHERE RNUM BETWEEN ? AND ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setString(1, search.getLcOne());
			pstmt.setString(2, search.getLocalCode());
			pstmt.setString(3, search.getInterest());
			pstmt.setInt(4, pageInfo.getStartList());
			pstmt.setInt(5, pageInfo.getEndList()); 
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member member = new Member();
				
				member.setRowNum(rs.getInt("RNUM"));
				member.setMemberNo(rs.getInt("MEMBER_NO"));
				member.setMemberStatus(rs.getString("MEMBER_STATUS").charAt(0));
				member.setNatCode(rs.getInt("NAT_CODE"));
				member.setLcOne(rs.getInt("LC_ONE"));
				member.setLcOneLv(rs.getInt("LC_ONE_LV"));
				member.setLocalCode(rs.getInt("LOCAL_CODE"));
				member.setInterest(rs.getString("INTEREST"));
				member.setNickname(rs.getString("NICKNAME"));
				member.setOriginalFilename(rs.getString("ORIGINAL_FILENAME"));
				member.setNatName(rs.getString("NAT_NAME"));
				member.setLangName(rs.getString("LANG_NAME"));
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


	// 전달받은 회원번호로 DB에서 친구 여부 확인
	public boolean isFriend(Connection connection, int memberNo, int memberNo2) {
		boolean result = false;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT COUNT(*) "
				+ "FROM FRIEND "
				+ "WHERE FRND_ONE_STATUS = 'Y' AND FRND_TWO_STATUS = 'Y' AND FRND_ONE = ? AND FRND_TWO = ? ";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, memberNo);
			pstmt.setInt(2, memberNo2);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				if(rs.getInt("COUNT(*)") == 1) {
					result = true;
				} else {
					result = false;
				}
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return result;
	}

	// 친구 삭제 : 전달받은 friend 객체로 db에서 DELETE 
	public int friendDelete(Connection connection, Friend friend) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "DELETE FROM FRIEND "
				+ "WHERE (FRND_ONE = ? AND FRND_TWO = ?) OR (FRND_ONE = ? AND FRND_TWO = ?)";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, friend.getFrndOne());
			pstmt.setInt(2, friend.getFrndTwo());
			pstmt.setInt(3, friend.getFrndTwo());
			pstmt.setInt(4, friend.getFrndOne());
			
			result = pstmt.executeUpdate(); // 성공시 2
			
//			System.out.println("dao의 friendDelete" + result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	// 대기중인 친구 신청(나 N 상대 Y) 개수 조회 메소드
	public int getRequestCount(Connection connection, int no) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT COUNT(*) "
				+ "FROM FRIEND "
				+ "WHERE FRND_ONE_STATUS = 'N' AND FRND_TWO_STATUS = 'Y' AND FRND_ONE = ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
				
		return count;
	}

	// 대기중인 친구신청(나 N 상대 Y) 목록 조회 메소드
	public List<Member> getRequestList(Connection connection, int no, int count) {
		List<Member> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query ="SELECT ROWNUM AS RNUM, MEMBER_NO, NICKNAME "
				+ "FROM MEMBER "
				+ "WHERE MEMBER_NO IN ( "
				+ "                    SELECT FRND_TWO "
				+ "                    FROM MEMBER "
				+ "                    JOIN FRIEND ON(MEMBER_NO = FRND_ONE) "
				+ "                    WHERE FRND_ONE_STATUS = 'N' AND FRND_TWO_STATUS = 'Y' AND FRND_ONE = ? "
				+ ")";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Member member = new Member();
				
				member.setRowNum(rs.getInt("RNUM"));
				member.setMemberNo(rs.getInt("MEMBER_NO"));
				member.setNickname(rs.getString("NICKNAME"));
				
				list.add(member);
			}
			
//			System.out.println(list.toString());
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}
		
		return list;
	}

	// 회원번호로 피드 수 조회
	public int getFeedCount(Connection connection, int no) {
		int count = 0;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query ="SELECT COUNT(*) "
				+ "FROM FEED "
				+ "JOIN MEMBER ON(WRITER_NO = MEMBER_NO) "
				+ "WHERE MEMBER_NO = ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("COUNT(*)");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rs);
			close(pstmt);
		}		
		
		return count;
	}

	// 회원번호로 피드 리스트 조회
	public List<Feed> getFeedList(Connection connection, PageInfo pageInfo, int no) {
		List<Feed> list = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		String query = "SELECT RNUM, NO, ID, CONTENT, RENAMED_FILENAME, CREATE_DATE, STATUS "
				+ "FROM "
				+ "    (SELECT ROWNUM AS RNUM, NO, ID, CONTENT, RENAMED_FILENAME, CREATE_DATE, STATUS "
				+ "     FROM ( "
				+ "            SELECT F.NO, M.ID, F.CONTENT, F.RENAMED_FILENAME, F.CREATE_DATE, F.STATUS "
				+ "            FROM FEED F JOIN MEMBER M ON(F.WRITER_NO = M.MEMBER_NO) "
				+ "            WHERE F.STATUS = 'Y' AND F.WRITER_NO = ? ORDER BY F.NO DESC "
				+ "            ) "
				+ "    ) "
				+ "WHERE RNUM BETWEEN ? and ?";
		
		try {
			pstmt = connection.prepareStatement(query);
			
			pstmt.setInt(1, no);
			pstmt.setInt(2, pageInfo.getStartList());
			pstmt.setInt(3, pageInfo.getEndList());
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				Feed feed = new Feed();
				
				feed.setNo(rs.getInt("NO"));
				feed.setRowNum(rs.getInt("RNUM"));
				feed.setWriterId(rs.getString("ID"));
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

	// 특정 피드의 댓글 정보
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
	
}


