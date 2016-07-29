package com.poc.utils.util;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class ParamUtil {
	
	public static String getString(HttpServletRequest request, String key, String defaultValue){
		if(key==null){
			return defaultValue;
		}
		String value = request.getParameter(key);
		if(value==null || "".equals(value)){
			return defaultValue;
		}
		return value;		
	}
	
	public static String[] getValues(HttpServletRequest request, String key, String[] defaultValue){
		if(key==null){
			return defaultValue;
		}
		String[] values = request.getParameterValues(key);
		if(values==null || values.length==0){
			return defaultValue;
		}
		return values;
	}
	
	public static Integer getInteger(HttpServletRequest request, String key, Integer defaultValue){
		if(key==null){
			return defaultValue;
		}
		String value = request.getParameter(key);
		if(value==null || "".equals(value)){
			return defaultValue;
		}
		return Integer.valueOf(value);
	}
	
	public static Integer[] getIntegers(HttpServletRequest request, String key, Integer[] defaultValue){
		if(key==null){
			return defaultValue;
		}
		String[] values = getValues(request, key, null);
		if(values==null || values.length==0){
			return defaultValue;
		}
		
		Integer[] result = new Integer[values.length];
		for(int i=0; i<values.length; i++){
			if(StringUtil.isNumber(values[i])){
				result[i] = Integer.valueOf(values[i]);
			}
		}
		return result;
	}
	
	public static Double getDouble(HttpServletRequest request, String key, Double defaultValue){
		if(key==null){
			return defaultValue;
		}
		String value = request.getParameter(key);
		if(value==null || "".equals(value)){
			return defaultValue;
		}
		return Double.valueOf(value);
	}
	
	public static Double[] getDoubles(HttpServletRequest request, String key, Double[] defaultValue){
		if(key==null){
			return defaultValue;
		}
		String[] values = getValues(request, key, null);
		if(values==null || values.length==0){
			return defaultValue;
		}
		
		Double[] result = new Double[values.length];
		for(int i=0; i<values.length; i++){
			if(StringUtil.isNumber(values[i])){
				result[i] = Double.valueOf(values[i]);
			}
		}
		return result;
	}

	public static Long getLong(HttpServletRequest request, String key, Long defaultValue){
		if(key==null){
			return defaultValue;
		}
		String value = request.getParameter(key);
		if(value==null || "".equals(value)){
			return defaultValue;
		}
		return Long.valueOf(value);
	}
	
	public static Long[] getLongs(HttpServletRequest request, String key, Long[] defaultValue){
		if(key==null){
			return defaultValue;
		}
		String[] values = getValues(request, key, null);
		if(values==null || values.length==0){
			return defaultValue;
		}
		
		Long[] result = new Long[values.length];
		for(int i=0; i<values.length; i++){
			if(StringUtil.isNumber(values[i])){
				result[i] = Long.valueOf(values[i]);
			}
		}
		return result;
	}
	
	public static Date getDate(HttpServletRequest request, String key, String pattern, Date defaultValue){
		if(key==null){
			return defaultValue;
		}
		String value = request.getParameter(key);
		if(value==null || "".equals(value)){
			return defaultValue;
		}
		return DateUtil.parseDate(value, pattern);
	}
	
	public static Boolean getBoolean(HttpServletRequest request, String key){
		if(key==null){
			return false;
		}
		String value = request.getParameter(key);
		if(value==null || "".equals(value)){
			return false;
		}
		return Boolean.valueOf(value);
	}
	
}
