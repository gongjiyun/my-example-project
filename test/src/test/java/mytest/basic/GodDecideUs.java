/**
This class add by Administrator
*/
package mytest.basic;

public class GodDecideUs {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		//һ���������һ��������XXXX.XX��������λΪ׼����������������Ͳ�ȥ������ż����ȥ����Ϊ����
		int many = 0;
		while(many < 7){
			double result = Math.random()*10000;
			String start = String.valueOf(result);
			System.out.println("" + start);
			start = start.substring(0, start.indexOf("."));
			int rint = Integer.valueOf(start);
			if(rint%2 == 1){
				System.out.println("��ȥ��");
			}else{
				System.out.println("ȥ��");
			}
			many++;
		}
	}
}
