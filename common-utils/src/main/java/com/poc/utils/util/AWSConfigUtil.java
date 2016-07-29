package com.poc.utils.util;

import java.io.InputStream;
import java.util.Properties;

public class AWSConfigUtil {
	private static AWSConfigUtil instance = new AWSConfigUtil();
	private static Properties prop = new Properties();
	static{
		InputStream is1 = null;
		try {
			Properties p1 = new Properties();
			is1 = AWSConfigUtil.class.getResourceAsStream("/aws.properties");
			prop.putAll(p1);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			try {
				if(is1!=null){
					is1.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}

		}
		
	}
	
	private AWSConfigUtil(){
		
	}
	
	public static AWSConfigUtil getInstance(){
		return instance;
	}

	public String getString(String key){
		if(prop!=null){
			return prop.getProperty(key);
		}
		return null;
	}	
}
