/**
This class add by Administrator
*/
package mytest.basic;

import java.util.HashMap;
import java.util.Map;

public class Byte2Generate {
	public static String gen(String str){
		long l = Long.valueOf(str);
		StringBuffer bf = new StringBuffer();
		gen(bf, l);
		String res = bf.toString();
		String dest = "";
		for(int i=res.length()-1; i>=0; i--){
			dest = dest + res.charAt(i);
		}
		return dest;
	}
	
	private static void gen(StringBuffer bf, long num){
		if(num%2==1){
			bf.append("1");
		}else{
			bf.append("0");
		}
		long rest = num/2;
		if(rest!=0){
			gen(bf, rest);			
		}
	}
	public static String getValue(String num){
		long res = 0;
		for(int i = 0 ; i < num.length(); i++){
			String c = num.substring(num.length()-i-1,num.length()-i);
			int v = Integer.valueOf(c);
			res = res + (long)(v * Math.pow(2, i));
		}
		return String.valueOf(res);
	}
	
	public static void main(String[] args) {
		System.out.println(gen(String.valueOf(Integer.MAX_VALUE)).length());
		System.out.println(getValue("101"));
		System.out.println(getValue("1111111111111111111111111111111"));
		
		long cap = 1;
		for(int i=0; i<20; i++){
			cap<<=1;
		}
		double b = (cap * 15l);
		System.out.println("memory(G): " + (b) / (1024 * 1024 * 1024));
	
		Map<String,String> map = new HashMap<String, String>();
		for(int i=0; i<cap; i++){
			map.put("key"+i, "value"+i);
		}
		for(int i=0; i<cap; i++){
			System.out.println(map.get("key"+i));
		}
	}
}
