/**
This class add by Administrator
*/
package test;

import com.poc.business.ejb.Person;
import com.poc.business.ejb.PersonHome;
import com.poc.business.util.EJBFactory;

public class TestBMPEntity {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
		PersonHome ph = (PersonHome) EJBFactory.getInstance().lookupHome(PersonHome.class, "ejb/person");
		Person person = ph.create("E1", "entity bean1");		
	}

}
