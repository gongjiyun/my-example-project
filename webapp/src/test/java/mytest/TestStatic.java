package mytest;

import java.util.HashMap;
import java.util.Map;

public class TestStatic {
	
	private static TestStatic t1 = new TestStatic("t1");
	private static TestStatic t2 = new TestStatic("t2");
	private static int k = 0;
	
	static{
		System.out.println("init k - " + (++k));
	}
	private static int i = 0;
	public TestStatic(String str){
		System.out.println("init - " + str);
		System.out.println("init i - " + (++i));
		
	}
	public static void main(String[] args) {
		Map<String, String> map = new HashMap<>();
		test();
	}
	
	public static void test(){
		System.out.println("test method, k = " + k);
	}

}
