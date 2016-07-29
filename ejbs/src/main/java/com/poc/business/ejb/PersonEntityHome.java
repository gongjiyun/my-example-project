/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;
import javax.ejb.FinderException;

public interface PersonEntityHome extends EJBHome {
	PersonEntity create(String nric, String name) throws CreateException, RemoteException;
	PersonEntity findByPrimaryKey(String pk) throws FinderException, RemoteException;
	PersonEntity findPersonById(String id) throws FinderException, RemoteException;
}
