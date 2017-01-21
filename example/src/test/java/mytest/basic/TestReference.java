package mytest.basic;

public class TestReference {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		MyVO v1 = new MyVO(0, 0);
		MyVO v2 = new MyVO(0, 0);
		System.out.println("v1 x = " + v1.x + "v1 y = " + v1.y);
		System.out.println("v2 x = " + v2.x + "v2 y = " + v1.y);
		change(v1, v2);
		System.out.println("v1 x = " + v1.x + "v1 y = " + v1.y);
		System.out.println("v2 x = " + v2.x + "v2 y = " + v1.y);
	}
	
	public static void change(MyVO v1, MyVO v2){
		v1.x = 100;
		v1.y = 100;
		MyVO temp = v1;
		v1 = v2;
		v2 =temp;
	}
}
