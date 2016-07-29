package mytest.jaas;

public class MyAWTPermision {
	public static void main(String[] args) {
		SecurityManager sm = System.getSecurityManager();
		if(sm != null){
			if(sm.checkTopLevelWindow(MyAWTPermision.class)){
				System.out.println("create a window.");
			}else{
				System.out.println("can not create a window.");
			}
		}else{
			System.out.println("Have no SecurityManager.");
		}
	}
}
