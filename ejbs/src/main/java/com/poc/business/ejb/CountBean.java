/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.ejb.SessionSynchronization;

public class CountBean implements SessionBean, SessionSynchronization {
	public final static String beanName = "CountBean";
	SessionContext ctx=null;
	private int count = 0;
	public void ejbCreate(int c){
		count = c;
		System.out.println("CountBean ejbCreate()");
	}

	public int count() throws RemoteException{
		count++;
		System.out.println("CountBean count() > " + count);
		return this.count;
	}

	public void ejbActivate() throws EJBException, RemoteException {
		System.out.println("CountBean ejbActivate()");
	}

	public void ejbPassivate() throws EJBException, RemoteException {
		System.out.println("CountBean ejbPassivate()");
	}

	public void ejbRemove() throws EJBException, RemoteException {
		System.out.println("CountBean ejbRemove()");
	}

	public void setSessionContext(SessionContext ctx) throws EJBException,
			RemoteException {
		this.ctx = ctx;
		System.out.println("CountBean setSessionContext()");
	}

	public void afterBegin() throws EJBException, RemoteException {
		System.out.println("CountBean afterBegin()");
	}

	public void afterCompletion(boolean committed) throws EJBException,
			RemoteException {
		System.out.println("CountBean afterCompletion()");
	}

	public void beforeCompletion() throws EJBException, RemoteException {
		System.out.println("CountBean beforeCompletion()");
	}
}
