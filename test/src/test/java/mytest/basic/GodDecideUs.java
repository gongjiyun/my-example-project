/**
This class add by Administrator
*/
package mytest.basic;

public class GodDecideUs {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		//一下随机产生一个数，如XXXX.XX，以整数位为准。如果产生奇数，就不去怀化。偶数则去，永为例。
		int many = 0;
		while(many < 7){
			double result = Math.random()*10000;
			String start = String.valueOf(result);
			System.out.println("" + start);
			start = start.substring(0, start.indexOf("."));
			int rint = Integer.valueOf(start);
			if(rint%2 == 1){
				System.out.println("不去！");
			}else{
				System.out.println("去！");
			}
			many++;
		}
	}
}
