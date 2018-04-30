package com.learning.service;

import com.learning.common.entities.Classes;
import com.learning.dao.ClassesDao;
import com.learning.utils.exception.SystemException;
import org.springframework.beans.factory.annotation.Autowired;

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
