/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;
import java.util.Collection;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

public interface PersonHome extends EJBHome{
	Person create(String id, String name) throws CreateException, RemoteException;
	Collection findPersons() throws FinderException, RemoteException;
	Collection findPersonById(String id) throws FinderException, RemoteException;
	Person findByPrimaryKey(PersonPK pk) throws FinderException, RemoteException;
}
