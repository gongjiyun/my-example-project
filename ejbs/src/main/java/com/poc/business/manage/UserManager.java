package com.poc.business.manage;

import com.poc.common.model.UserVO;

/**
 * Target       : 
 * Created By   : jiyun
 * Created Date : May 5, 2011
 * Version      :
 * Remarks      :
 */
public interface UserManager {
	
	UserVO getUserByUserId(String userId) throws Exception;
	
}
