package com.kh.kingto.common.util;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.oreilly.servlet.multipart.FileRenamePolicy;

// File Rename 정책 만들기 위해서 FileRenamePolicy 인터페이스를 구현한다.
public class FileRename implements FileRenamePolicy {
	
	// 해당 메소드를 구현해 업로드되는 파일의 이름을 변경할 수 있다.
	@Override
	public File rename(File oldFile) {		
		File newFile = null;
		int randomNum = 0;
		LocalDateTime dateTime = null;
		String oriName = null;
		String newName = null;
		String extension = null;	
		int dot = -1;
		
		do { 
			// 현재 파일의 이름을 변경 (날짜_랜덤수.파일확장자 형식으로 변경)
			dateTime = LocalDateTime.now(); // 현재 시간						
			randomNum = (int)(Math.random() * 1000);			 
			oriName = oldFile.getName(); // 확장자 포함 파일명 가져오기
			extension = "";			
			dot = oriName.lastIndexOf("."); // adfds.txt, asdfasf.hwp
			
			if(dot > -1) {
				extension = oriName.substring(dot); // 확장자명 가져오기
			}
			
			// 새 파일 이름 만들기 (날짜_랜덤수.파일확장자)
			newName = dateTime.format(DateTimeFormatter.ofPattern("yyyyMMdd_HHmmssSSS")) + "_" + randomNum + extension;
			// getParent() : 부모 경로에 대한 경로명을 문자열로 넘겨준다.
			newFile = new File(oldFile.getParent(), newName);			
		} while (!createNewFile(newFile));
		
		return newFile;
	}
	
	private boolean createNewFile(File file) {
		try {
			return file.createNewFile();
		}catch(IOException e) {
			return false;
		}
	}
}