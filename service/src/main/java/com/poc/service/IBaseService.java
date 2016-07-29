package com.poc.service;

import com.poc.utils.exception.SystemException;


/**
 **Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public interface IBaseService {
	
	public long generatePrimaryKey(Class<?> clazz) throws SystemException;
	
}
