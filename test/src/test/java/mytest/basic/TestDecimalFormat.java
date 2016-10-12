package mytest.basic;

import java.text.DecimalFormat;

public class TestDecimalFormat {

	public static void main(String[] args) {
		DecimalFormat df = new DecimalFormat("#,###.####");
		//df.format(12.0100);
		System.out.println(df.format(12.0100));
	}
	
}
