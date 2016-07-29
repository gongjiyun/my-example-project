/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.EJBObject;

public interface Count extends EJBObject{
	int count() throws RemoteException;
}
