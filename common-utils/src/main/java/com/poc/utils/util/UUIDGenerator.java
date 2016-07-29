package com.poc.utils.util;

import java.util.Date;

public class UUIDGenerator {
	private static UUIDGenerator instance = null;
	private UUIDGenerator(){
		
	}
	public static UUIDGenerator getInstance(){
		if(instance==null){
			instance = new UUIDGenerator();
		}
		return instance;
	}
	
	public String uuid(){
		String result = "";
		try{
			String date = DateUtil.formatDate(new Date(), "yyyyMMddHHmmssSSS");
			String radom = String.valueOf(Math.random()*10000).substring(6);
			String thread = String.valueOf(Thread.currentThread().hashCode());
			result = new String(date + radom + thread);
			//result = new BASE64Encoder().encode(result.getBytes());
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result.substring(0,30).toLowerCase();
	}
	
	public static void main(String[] args) {
		for(int i=0;i<10;i++){
			System.out.println(UUIDGenerator.getInstance().uuid());
		}
		
	}
}
