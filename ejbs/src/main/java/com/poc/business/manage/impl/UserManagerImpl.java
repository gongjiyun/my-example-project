package com.poc.business.manage.impl;

import com.poc.business.manage.UserManager;
import com.poc.common.model.UserVO;
import com.poc.dao.UserDao;

/**
 * Target       : 
 * Created By   : jiyun
 * Created Date : May 5, 2011
 * Version      :
 * Remarks      :
 */
public class UserManagerImpl implements UserManager{
	
	private UserDao userDAO;

	public UserVO getUserByUserId(String userId) throws Exception {
		return null;
	}

	public UserDao getUserDAO() {
		return userDAO;
	}

	public void setUserDAO(UserDao userDAO) {
		this.userDAO = userDAO;
	}

}
