/**
This class add by Administrator
*/
package test;

import com.poc.business.ejb.PersonEntity;
import com.poc.business.ejb.PersonEntityHome;
import com.poc.business.util.EJBFactory;


public class TestCMPEntity {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		PersonEntityHome ph = (PersonEntityHome) EJBFactory.getInstance().lookupHome(PersonEntityHome.class, "ejb/PersonEntity");
		PersonEntity person = ph.findPersonById("S22222D");
		System.out.println("name > " + person.getName());
		person.setName("update by CMP Entity bean");
		person.setEmail("jiyun@hotmail.com");
	}

}
