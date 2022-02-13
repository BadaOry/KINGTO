package com.kh.kingto.notice.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Notice {
	private int no;
	
	private int nextNo;
	
	private int prevNo;

	private String nextTitle;
	
	private String prevTitle;
	
	private int rowNum;
	
	private int writerNo;
	
	private String writerId;
	
	private String title;
	
	private String content;
	
	private int readCount;
	
	private String status;
	
	private Date createdDate;
	
	private Date modifyDate;


	
}
