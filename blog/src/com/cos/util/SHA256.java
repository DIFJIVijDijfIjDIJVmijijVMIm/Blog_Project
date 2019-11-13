package com.cos.util;

import java.security.MessageDigest;


//256bit 길이의 암호 = 해시 = 복호화가 안됨
public class SHA256 {
	//password를 암호화해서 return
	
	public static String getEncrypt(String rawPassword, String salt) {
		
		//ex) rawPassword = "qw5678qw";   salt = "cos";
		String result = "";
		
		//[q, w, 5, 6, 7, 8, q, w]
		
		byte[] b = (rawPassword + salt).getBytes();	
		
		try {
			
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			md.update(b);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		try {
			
			MessageDigest md = MessageDigest.getInstance(	"SHA-256");
			md.update(b);	//MessageDigest가 SHA-256으로 암호화된 값을 들고 있음.
			
			byte[] bResult = md.digest();
			
//			for(byte data : bResult) {
//				System.out.println(data + "  ");
//			}
			
			/*
			 * int를 byte타입으로 바꿀 때 숫자가 128을 넘어가면 첫번째 수가 1이면 마이너스, 0이면 플러스인 연산 때문에 데이터에 손실이 발생한다.
			 * 그 손실을 data & 0xff 라는 마스킹? 기법을 통해 복구를 해준다.  
			 */
			
			StringBuffer sb = new StringBuffer();
			for(byte data : bResult) {
				sb.append(Integer.toString(data & 0xff, 16));	//손실된 값을 End 연산을 통해 복구를 해주고, 16진수로 표현한다.
			}
			result = sb.toString();
			
			return result;
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return null;
		
	}
	
}
