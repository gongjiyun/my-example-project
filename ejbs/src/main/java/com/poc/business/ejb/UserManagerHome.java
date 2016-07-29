package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.CreateException;
import javax.ejb.EJBHome;

public interface UserManagerHome extends EJBHome {

	UserManager create() throws CreateException, RemoteException;
	
}
