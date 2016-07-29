/**
This class add by jiyun
 */
package com.poc.web.interceptor;

import java.io.Serializable;
import java.util.Iterator;

import org.hibernate.CallbackException;
import org.hibernate.EmptyInterceptor;
import org.hibernate.EntityMode;
import org.hibernate.Transaction;
import org.hibernate.type.Type;

public class HibernateInterceptor extends EmptyInterceptor {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	public void afterTransactionBegin(Transaction arg0) {
		System.out.println("HibernateInterceptor.afterTransactionBegin");
	}

	public void afterTransactionCompletion(Transaction arg0) {
		System.out.println("HibernateInterceptor.afterTransactionCompletion");
	}

	public void beforeTransactionCompletion(Transaction arg0) {
		System.out.println("HibernateInterceptor.beforeTransactionCompletion");
	}

	public int[] findDirty(Object arg0, Serializable arg1, Object[] arg2,
			Object[] arg3, String[] arg4, Type[] arg5) {
		System.out.println("HibernateInterceptor.findDirty");
		return null;
	}

	public Object getEntity(String arg0, Serializable arg1)
			throws CallbackException {
		System.out.println("HibernateInterceptor.getEntity()");
		return arg0;
	}

	public String getEntityName(Object arg0) throws CallbackException {
		System.out.println("HibernateInterceptor.getEntityName()");
		return arg0.getClass().getName();
	}

	public Object instantiate(String arg0, EntityMode arg1, Serializable arg2)
			throws CallbackException {
		System.out.println("HibernateInterceptor.instantiate()"+arg0);
		return arg0;
	}

	public Boolean isTransient(Object arg0) {
		System.out.println("HibernateInterceptor.isTransient()");
		return new Boolean(false);
	}

	public void onCollectionRecreate(Object arg0, Serializable arg1)
			throws CallbackException {
		System.out.println("HibernateInterceptor.onCollectionRecreate()");
	}

	public void onCollectionRemove(Object arg0, Serializable arg1)
			throws CallbackException {
		System.out.println("HibernateInterceptor.onCollectionRemove()");
	}

	public void onCollectionUpdate(Object arg0, Serializable arg1)
			throws CallbackException {
		System.out.println("HibernateInterceptor.onCollectionUpdate()");
	}

	public void onDelete(Object arg0, Serializable arg1, Object[] arg2,
			String[] arg3, Type[] arg4) throws CallbackException {
		System.out.println("HibernateInterceptor.onDelete()");
	}

	public boolean onFlushDirty(Object arg0, Serializable arg1, Object[] arg2,
			Object[] arg3, String[] arg4, Type[] arg5) throws CallbackException {
		System.out.println("HibernateInterceptor.onFlushDirty()");
		return false;
	}

	public boolean onLoad(Object arg0, Serializable arg1, Object[] arg2,
			String[] arg3, Type[] arg4) throws CallbackException {
		System.out.println("HibernateInterceptor.onLoad()");
		return false;
	}

	public String onPrepareStatement(String arg0) {
		System.out.println("HibernateInterceptor.onPrepareStatement()" + arg0);
		return arg0;
	}

	public boolean onSave(Object arg0, Serializable arg1, Object[] arg2,
			String[] arg3, Type[] arg4) throws CallbackException {
		System.out.println("HibernateInterceptor.onSave()");
		return false;
	}

	public void postFlush(Iterator arg0) throws CallbackException {
		System.out.println("HibernateInterceptor.postFlush()");
	}

	public void preFlush(Iterator arg0) throws CallbackException {
		System.out.println("HibernateInterceptor.preFlush");
	}

}
