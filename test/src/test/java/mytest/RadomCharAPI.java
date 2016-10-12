package mytest;

public class RadomCharAPI {
	private final static String CHARS = "abcdefghigklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
	public static void main(String[] args) throws Exception{
		int i=0;
		while(true){
			if(i==5){
				break;
			}
			long t = System.currentTimeMillis();
			Thread.sleep(1000);
			int index = (int) (t % 52);
			System.out.println(CHARS.charAt(index));
			i++;
		}
		
	}

}
