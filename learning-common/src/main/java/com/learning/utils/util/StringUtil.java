package com.learning.utils.util;

import org.apache.commons.lang.StringUtils;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.Collection;

public class StringUtil {
	private final static String NUMBER = "0123456789";
	
	public static boolean contains(String test, String[] srcs){
		if(test==null || srcs==null || srcs.length==0){
			return false;
		}
		for(String str : srcs){
			if(test.equals(str)){
				return true;
			}
		}
		return false;
	}
	
	public static boolean isNull(Object test){
		if(test==null){
			return true;
		}
		if(test instanceof String){
			String s = (String)test;
			if("".equals(s.toString())){
				return true;
			}
		}else if(test instanceof Collection){
			Collection<?> cl = (Collection<?>)test;
			if(cl.size()==0 || cl.isEmpty()){
				return true;
			}
		}
		return false;
	}
	
	public static boolean isNumber(String test){
		if(test==null){
			return false;
		}
		try {
			for(int i=0; i<test.length(); i++){
				char ca = test.charAt(i);
				if(NUMBER.indexOf(String.valueOf(ca))<0){
					return false;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}
	
	public static boolean isDouble(String test){
		if(test==null){
			return false;
		}
		try {
			boolean is1 = test.matches("\\d+\\.\\d+");
			boolean is2 = test.matches("\\d+");
			if(is1 || is2){
				return true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return false;
	}
	
	public static String valueOf(Object test){
		if(test==null){
			return "";
		}
		try {
			return String.valueOf(test);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "";
	}
	
	/**
	 * This method is used to covert the price like 5.844444444445 to 5.85, it's will auto round half up start from 15th decimal
	 * @param price
	 * @return
	 */
	public static BigDecimal convertPriceAmount(double price) {
		BigDecimal bd = new BigDecimal(price);
		//bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
		/*for (int i = 15; i > 1; i--) {
			bd = bd.setScale(i, BigDecimal.ROUND_HALF_UP);
			price = bd.doubleValue();
		}*/
		bd = new BigDecimal(price);
		bd = bd.setScale(2, BigDecimal.ROUND_HALF_UP);
		return bd;
	}
	
	public static BigDecimal convertPriceAmount(double price, int decimalPoint) {

		BigDecimal bd = new BigDecimal(price);
		bd = new BigDecimal(price);
		bd = bd.setScale(decimalPoint, BigDecimal.ROUND_HALF_UP);
		return bd;
	}
	
	public static String formatNegativeDollar(double price, String pattern) {
		try {
			DecimalFormat df = new DecimalFormat(pattern);
			String result = "";
			if(price>=0){
				result = df.format(price);
			}else{
				price = 0 - price;
				result = "(" + df.format(price) + ")";
			}
			return result;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return String.valueOf(price);
	}
	
	public static String formatDollar(Object price, String pattern) {
		try {
			DecimalFormat df = new DecimalFormat(pattern);
			return df.format(price);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return price.toString();
	}
	
	public static String array2String(String[] array, String pattern) {
		try {
			if(array==null){
				return null;
			}
			String dest = "";
			for(String s : array){
				dest = dest + s + pattern;
			}
			return dest.substring(0, dest.length()-1);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static String array2String(long[] array, String pattern) {
		try {
			if(array==null){
				return null;
			}
			String dest = "";
			for(long s : array){
				dest = dest + s + pattern;
			}
			return dest.substring(0, dest.length()-1);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static String array2String(Object[] array, String pattern) {
		try {
			if(array==null){
				return null;
			}
			String dest = "";
			for(Object s : array){
				dest = dest + s + pattern;
			}
			return dest.substring(0, dest.length()-1);
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public static void printExceptionTrace(Exception ex){
		StringWriter sw = new StringWriter();
		ex.printStackTrace(new PrintWriter(sw, true));
		System.out.println(sw.toString());
	}
	
	public static String getExceptionTrace(Exception ex, int length){
		StringWriter sw = new StringWriter();
		ex.printStackTrace(new PrintWriter(sw, true));
		if(length==-1){
			return sw.toString();
		}
		String mesg = sw.toString();
		return mesg.substring(0, length);
	}
	
	
	public static void main(String[] args) {
		System.out.println(array2String(new Integer[]{1, 2}, ","));
	}

	public static boolean isNotBlank(String name) {
		return StringUtils.isNotBlank(name);
	}
}
