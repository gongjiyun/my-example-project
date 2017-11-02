package com.xxooframe.utils.util;


public class FileUtil {
	
	public static String getExtension(String fileName){
		if(fileName==null){
			return "";
		}
		if(fileName.indexOf(".")>0){
			int idex = fileName.lastIndexOf(".");
			return fileName.substring(idex+1);
		}
		return "";
	}
}
