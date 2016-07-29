/**
This class add by Administrator
*/
package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.EntityBean;
import javax.ejb.EntityContext;
import javax.ejb.RemoveException;

public abstract class PersonEntityBean implements EntityBean{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private EntityContext ctx = null;
	/*
	private String nric;
	private String name;
	private String email;
	
	public String getNric(){
		return this.nric;
	}
	public void setNric(String nric){
		this.nric = nric;
	}
	public String getName(){
		return this.name;
	}
	public void setName(String name){
		this.name = name;
	}
	public String getEmail(){
		return this.email;
	}
	public void setEmail(String email){
		this.email = email;
	}
	*/
	
	public abstract String getNric();
	public abstract void setNric(String nric);
	public abstract String getName();
	public abstract void setName(String name);
	public abstract String getEmail();
	public abstract void setEmail(String email);
	
	public String ejbCreate(String nric, String name){
		setNric(nric);
		setName(name);
		System.out.println("PersonEntityBean ejbCreate()");
		return nric;
	}
	
	public void ejbPostCreate(String nric, String name){
		System.out.println("PersonEntityBean ejbPostCreate()");
	}
	
	/*public String ejbFindByPrimaryKey(String pk){
		System.out.println("PersonEntityBean ejbFindByPrimaryKey()");
		return null;
	}
	
	public String ejbFindPersonById(String id){
		System.out.println("PersonEntityBean ejbFindPersonById()");
		return null;
	}*/
	
	public void ejbActivate() throws EJBException, RemoteException {
		System.out.println("PersonEntityBean ejbActivate()");
	}

	public void ejbLoad() throws EJBException, RemoteException {
		System.out.println("PersonEntityBean ejbLoad()");
	}

	public void ejbPassivate() throws EJBException, RemoteException {
		System.out.println("PersonEntityBean ejbPassivate()");
	}

	public void ejbRemove() throws RemoveException, EJBException,
			RemoteException {
		System.out.println("PersonEntityBean ejbRemove()");
	}

	public void ejbStore() throws EJBException, RemoteException {
		System.out.println("PersonEntityBean ejbStore()");
	}

	public void setEntityContext(EntityContext ctx) throws EJBException,
			RemoteException {
		this.ctx = ctx;
		System.out.println("PersonEntityBean setEntityContext()");
	}

	public void unsetEntityContext() throws EJBException, RemoteException {
		this.ctx = null;
		System.out.println("PersonEntityBean unsetEntityContext()");
	}
	
}
