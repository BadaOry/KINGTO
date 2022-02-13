package com.kh.kingto.friends.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FriendsList {
	private int frndTwo;
	
	private int rowNum; // 페이징 위한 rownum 
	
	private String frndStatus;
	
	private int natCode;
	
	private int lcOne;
	
	private int lcOneLv;
		
	private int localCode;
	
	private String interest;
	
	private String nickname;
	
	private int lcTwo;
	
	private int lcTwoLv;
	
	private int lcThr;
	
	private int lcThrLv;
	
	private String originalFilename;
	
	private String natName;
	
	private String langName;

}
