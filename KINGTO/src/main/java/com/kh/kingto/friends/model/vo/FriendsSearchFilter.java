package com.kh.kingto.friends.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class FriendsSearchFilter {
	private String lcOne; // LC_ONE : 모국어
	
	private String localCode; // LOCAL_CODE : 지역
	
	private String interest;	

}
