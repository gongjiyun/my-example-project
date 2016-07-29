/**
This class add by Administrator
*/
package test;

import com.poc.business.ejb.UserManager;
import com.poc.business.ejb.UserManagerHome;
import com.poc.business.util.EJBFactory;

public class TestStatelessBean {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		UserManagerHome umhome = (UserManagerHome) EJBFactory.getInstance().lookupHome(UserManagerHome.class, "ejb/UserManager");
		UserManager um = umhome.create();
		um.getUserByUserId("test1");
		Thread.sleep(10000);
		um.getUserByUserId("test2");
	}

}
