/**
This class add by jiyun
 */
package mytest.basic.p2;

import java.lang.reflect.Method;

public class PackageClass2 {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		Class clazz = Class.forName("test.basic.p1.PackageClass1");
		Method[] mths = clazz.getDeclaredMethods();
		Object obj = clazz.newInstance();
		for (Method m : mths) {
			m.invoke(obj, null);
		}
	}

}
