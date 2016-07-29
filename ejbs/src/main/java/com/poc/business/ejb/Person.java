/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.EJBObject;

public interface Person extends EJBObject{
	public void updatePerson(String nric, String email, String birth, String gender) throws RemoteException;
	public String getNric() throws RemoteException;
	public void setNric(String nric) throws RemoteException;
	public String getName() throws RemoteException;
	public void setName(String name) throws RemoteException;
	public String getEmail() throws RemoteException;
	public void setEmail(String email) throws RemoteException;
}
