/**
This class add by Administrator
*/
package test;

import com.poc.business.ejb.Count;
import com.poc.business.ejb.CountHome;
import com.poc.business.util.EJBFactory;

public class TestStatefulBean {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		CountHome chome = (CountHome) EJBFactory.getInstance().lookupHome(CountHome.class, "ejb/count");
		System.out.println("get home");
		Count ct = chome.create(0);
		System.out.println("home create ejb object.");
		ct.count();	
		Thread.sleep(12000);
		ct.count();
	}

}
