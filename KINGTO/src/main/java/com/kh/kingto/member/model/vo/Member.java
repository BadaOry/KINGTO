package com.kh.kingto.member.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private int memberNo;
	
	private char memberStatus;
	
	private String memberRole;
	
	private int natCode;
	
	private int lcOne;
	
	private int lcOneLv;
		
	private int localCode;
	
	private String interest;
	
	private String id;
	
	private String pwd;
	
	private String email;
	
	private String nickname;
	
	private int lcTwo;
	
	private int lcTwoLv;
	
	private int lcThr;
	
	private int lcThrLv;
	
	private Date enrollDate;
	
	private Date modifyDate;
	
	private String originalFilename;
	
	private int rowNum; // 페이징 위한 rowNum 추가
	
	private String langName;
	
	private String langNameEng;
	
	private String natName;
	
	private String natNameEng;

}
