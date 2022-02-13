package com.kh.kingto.post.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PostList {
	private int post_no;
	
	private int rowNum;
	
	private int post_member;
	
	private int post_sgroup_no; 
	
	private String post_id; 
	
	private String post_title;
	
	private String post_cont;
	
	private int post_readcount;
	
	private String post_status;
	
	private String post_like;
	
	private Date post_create;
	
	private Date post_modify;

	
}
