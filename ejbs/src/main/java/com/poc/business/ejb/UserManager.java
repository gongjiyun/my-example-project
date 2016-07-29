package com.poc.business.ejb;

import java.rmi.RemoteException;

import javax.ejb.EJBException;
import javax.ejb.EJBObject;

import com.poc.common.model.UserVO;

/**
 * Target       : 
 * Created By   : jiyun
 * Created Date : May 5, 2011
 * Version      :
 * Remarks      :
 */
public interface UserManager extends EJBObject {
	UserVO getUserByUserId(String userId) throws EJBException, RemoteException;
}
