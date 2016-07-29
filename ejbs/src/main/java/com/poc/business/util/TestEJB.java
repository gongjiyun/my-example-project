/**
This class add by Administrator
*/
package com.poc.business.util;

import com.poc.business.ejb.Person;
import com.poc.business.ejb.PersonHome;
import com.poc.business.ejb.PersonPK;

public class TestEJB {
	
	/**
	 * 
	 * @param args
	 * @throws Exception
	 */
	public static void main(String[] args) throws Exception{
		//test stateless bean.
		/*
		UserManagerHome umhome = (UserManagerHome) EJBFactory.getInstance().lookupHome(UserManagerHome.class, "ejb/UserManager");
		UserManager um = umhome.create();
		um.getUserByUserId("test1");
		Thread.sleep(10000);
		um.getUserByUserId("test2");
		*/
		
		//test stateful bean.
		/*
		CountHome chome = (CountHome) EJBFactory.getInstance().lookupHome(CountHome.class, "ejb/count");
		System.out.println("get home");
		Count ct = chome.create(0);
		System.out.println("home create ejb object.");
		ct.count();	
		Thread.sleep(12000);
		ct.count();
		*/
		
		//test entity bean.
		PersonHome ph = (PersonHome) EJBFactory.getInstance().lookupHome(PersonHome.class, "ejb/person");
		Person newp = ph.create("S0000000S", "entity bean");
		System.out.println("name > " + newp.getName());
		
		Person p= ph.findByPrimaryKey(new PersonPK("S12345678D"));
		System.out.println("name > " + p.getName());
		
		/*List cl = (List) ph.findPersonById("S12345678D");
		Iterator it = cl.iterator();
		System.out.println("get list key : " + cl);
		while(it.hasNext()){
			Person person =(Person) it.next();
			//System.out.println("name : " +  person.getName());			
			person.updatePerson("test", "19000909", "F");		
		}*/
	}
}
