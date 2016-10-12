/**
This class add by Administrator
*/
package mytest.basic;

public class Finally extends Thread{
	@SuppressWarnings("finally")
	public int getI() {
		while(this.isAlive()){
			System.out.println("still alive.");
		}
		
		int i = 0;
		try{
			System.out.println("try");
			i = 1/0 ;
			return i;
		}catch(Exception e){
			System.out.println("catch");
			i = 2;
			return i;
		}finally{
			System.out.println("finally");
			return i;
		}

	}
	public static void main(String[] args) {
		System.out.println(new Finally().getI());
	}
}
