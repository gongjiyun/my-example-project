package com.poc.service;

import org.springframework.beans.factory.annotation.Autowired;

import com.poc.common.entities.Classes;
import com.poc.dao.ClassesDao;
import com.poc.utils.exception.SystemException;

public abstract class AbstractBaseService implements IBaseService{
	
	@Autowired
	private ClassesDao classesDao;	
	public synchronized long generatePrimaryKey(Class<?> clazz) throws SystemException{
		try {
			return classesDao.generateNextId(clazz);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public synchronized long getCurrentId(Class<?> clazz) throws SystemException{
		try {
			Classes claz = classesDao.findByClassName(clazz.getName());
			if(claz!=null){
				return claz.getCurrentId();
			}
			return 0;
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
}
