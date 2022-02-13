package com.kh.kingto.friends.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

// 친구이다 = Y Y

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Friend {
	private int frndOne; // ��û�� ȸ�� ��ȣ
	
	private int frndTwo; // ��û���� ȸ��( = �����) ��ȣ
	
	private char oneStatus;
	
	private char twoStatus;
	
	private Date frndDate;
	
	private Date modifyDate;
}
