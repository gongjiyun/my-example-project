package com.xxooframe.service;

import com.xxooframe.utils.exception.SystemException;


/**
 **Digital Banking Trends �C Banks�� Goal and NCS Presence
 **/
public interface IBaseService {
	
	public long generatePrimaryKey(Class<?> clazz) throws SystemException;
	
}
