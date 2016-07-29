package com.poc.business.ejb;

import java.rmi.RemoteException;
import java.security.Principal;

import javax.ejb.CreateException;
import javax.ejb.EJBException;
import javax.ejb.EJBHome;
import javax.ejb.EJBObject;
import javax.ejb.Handle;
import javax.ejb.RemoveException;
import javax.ejb.SessionBean;
import javax.ejb.SessionContext;
import javax.naming.Context;
import javax.naming.InitialContext;

import com.poc.common.model.UserVO;

/**
 * Target       : 
 * Created By   : jiyun
 * Created Date : May 5, 2011
 * Version      :
 * Remarks      :
 */
public class UserManagerBean implements UserManager, SessionBean {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	SessionContext ctx=null;
	private int count = 0;
	
	public void ejbCreate()throws CreateException{
		count++;
		System.out.println("UserManagerBean ejbCreate()");
	}
	
	public UserVO getUserByUserId(String userId) throws EJBException{
		count++;
		System.out.println("UserManagerBean getUserByUserId()#" + userId);
		System.out.println("count : " + count);
		
		//test ejb;		
		try {
			System.out.println("test ENC start");
			Context ctx = new InitialContext();
			ctx = (Context) ctx.lookup("java:comp/env/");
			PersonHome chome = (PersonHome) ctx.lookup("person");
			Person p = chome.create("S-001", "UserManagerBean Test ENC");
			System.out.println("test ENC end");
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		//check security.
		System.out.println("check security.");
		if(!ctx.isCallerInRole("administrator")){
			throw new SecurityException("not a privilege role.");
		}
		Principal id = ctx.getCallerPrincipal();
		System.out.println(id.getName());

		return null;
	}

	public void ejbActivate() throws EJBException, RemoteException {
		System.out.println("UserManagerBean ejbActivate()");
	}

	public void ejbPassivate() throws EJBException, RemoteException {
		System.out.println("UserManagerBean ejbPassivate()");
	}

	public void ejbRemove() throws EJBException, RemoteException {
		System.out.println("UserManagerBean ejbRemove()");
	}

	public void setSessionContext(SessionContext arg0) throws EJBException{
		System.out.println("UserManagerBean setSessionContext()");
		this.ctx=arg0;
	}

	public EJBHome getEJBHome() throws RemoteException {
		// TODO Auto-generated method stub
		return null;
	}

	public Handle getHandle() throws RemoteException {
		// TODO Auto-generated method stub
		return null;
	}

	public Object getPrimaryKey() throws RemoteException {
		// TODO Auto-generated method stub
		return null;
	}

	public boolean isIdentical(EJBObject arg0) throws RemoteException {
		// TODO Auto-generated method stub
		return false;
	}

	public void remove() throws RemoteException, RemoveException {
		// TODO Auto-generated method stub
		
	}
}
