package com.learning.utils.util;

import java.util.Calendar;


public class PrimaryKeyUtil {
	private static PrimaryKeyUtil instance = new PrimaryKeyUtil();
	
	private PrimaryKeyUtil(){
		
	}
	
	public static PrimaryKeyUtil getInstance(){
		return instance;
	}
	
	public synchronized long generate(){
		Calendar cal = Calendar.getInstance();
		long id = cal.getTimeInMillis();
		long rid = (long)(Math.random()*9999999);
		System.out.println(rid);
		System.out.println(String.valueOf(id) + String.valueOf(rid));
		return Long.valueOf(String.valueOf(id) + String.valueOf(rid));
	}
	
	public static void main(String[] args) {
		PrimaryKeyUtil.getInstance().generate();
	}
}
