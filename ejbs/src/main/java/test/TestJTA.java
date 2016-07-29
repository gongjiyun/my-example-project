/**
This class add by Administrator
*/
package test;

import javax.naming.Context;
import javax.transaction.UserTransaction;

import com.poc.business.ejb.Person;
import com.poc.business.ejb.PersonEntity;
import com.poc.business.ejb.PersonEntityHome;
import com.poc.business.ejb.PersonHome;
import com.poc.business.util.EJBFactory;

public class TestJTA {

	public static void test() throws Exception{
		Context ctx = EJBFactory.getInstance().getCtx();
		
		UserTransaction tran = (UserTransaction) ctx.lookup("javax.transaction.UserTransaction");
		System.out.println(tran);
		try{
			tran.begin();

			PersonEntityHome peh = (PersonEntityHome) EJBFactory.getInstance().lookupHome(PersonEntityHome.class, "ejb/PersonEntity");
			PersonEntity pe = peh.findPersonById("E1");			
			pe.setName("test");
			pe.setEmail(pe.getNric() + "@hotmail.com");			
			
			
			PersonHome phome = (PersonHome) EJBFactory.getInstance().lookupHome(PersonHome.class, "ejb/person");
			Person p = phome.create("S0", "jta test");
			
			p.updatePerson("E1", "E1@hotmail.com", "19820821", "F"); // greater than length

			tran.commit();
		}catch(Exception e){
			e.printStackTrace();
			tran.rollback();
		}

	}
	public static void main(String[] args) throws Exception {
		TestJTA.test();
	}

}
