package com.kh.kingto.admin.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Report {
	private int reportNo;
	
	private Date reportDate;
	
	private int memberRp;
	
	private int memberRpd;
	
	private int rpd_feed_no;
	
	private String reportContent;
	
}
