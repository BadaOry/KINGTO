package com.kh.kingto.my_page.model.vo;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Feed {

	private int no; //'�ǵ��ȣ';
	
	private int rowNum; //'�ǵ����Ĺ�ȣ';
	
	private int writerNo; //'�ǵ��ۼ���ȸ����ȣ';
	
	private String writerId; //'�ǵ��ۼ��ھ��̵�';
	
	private int like; //'�ǵ����ƿ�';
	
	private String pageStatus; //'�ǵ峻��';
	
	private String content; //'�ǵ峻��';
	
	private String interest; //'�ǵ峻��';
	
	private String originalFileName; //'÷�����Ͽ����̸�';
	
	private String renameFileName; //'÷�����Ϻ����̸�';
	
	private String status; //'���°�(Y/N)';
	
	private Date createDate; //'�ǵ�ø���¥';
	
	private Date modifyDate; //'�ǵ������¥';
	
	private List<Replies> replies;


		
	}

