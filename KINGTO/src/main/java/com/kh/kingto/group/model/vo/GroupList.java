package com.kh.kingto.group.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class GroupList {
	private int sgroup_no; // 소모임 번호
	
	private int rowNum;
	
	private String id; 
	
	private int sgroup_admin; // 소모임장 회원번호
	
	private String sgroup_name; // 소모임 이름
	
	private String sgroup_open;
	
	private String sgroup_introduce;
	
	private String sgroup_img;
	
	private String sgroup_interest;

	private int sgroup_MemberCount;
	

	
}
