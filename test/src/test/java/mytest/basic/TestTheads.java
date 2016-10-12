/**
This class add by jiyun
 */
package mytest.basic;

public class TestTheads {
	private static boolean run = true;

	public static void main(String[] args) {
		try {
			class T1 implements Runnable {

				public void run() {
					try {
						Thread.sleep(10);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					System.out.println("T1");
					int i = 1 / 0;
				}

			}

			class T2 implements Runnable {

				public void run() {
					try {
						Thread.sleep(10);
					} catch (InterruptedException e) {
						e.printStackTrace();
					}
					System.out.println("T2");
					int i = 1 / 0;
				}

			}

			Thread t1 = new Thread(new T1());
			t1.setPriority(1);
			Thread t2 = new Thread(new T2());
			t2.setPriority(10);
			t1.start();
			t2.start();

		} catch (Exception e) {
			System.out.println("<can get exception>");
		}
	}

}
