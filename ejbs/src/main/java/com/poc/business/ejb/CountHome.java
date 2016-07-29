/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface CountHome extends EJBHome{
	Count create(int c) throws CreateException, RemoteException;
}
