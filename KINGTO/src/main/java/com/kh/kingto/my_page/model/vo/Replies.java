package com.kh.kingto.my_page.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Replies {
	
	private int no;
	private int feed_no;
	private String content;
	private String writer_id;
	private int writer_no;	
	private String status;
	private Date createDate;
	private Date modifyDate;
	
	
}
