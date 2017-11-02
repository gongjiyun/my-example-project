package com.xxooframe.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.xxooframe.common.entities.Classes;
import com.xxooframe.dao.ClassesDao;
import com.xxooframe.service.AbstractBaseService;
import com.xxooframe.service.AssetEntryService;
import com.xxooframe.utils.exception.SystemException;

@Service("assetEntryService")
public class AssetEntryServiceImpl extends AbstractBaseService implements AssetEntryService {
	private final static Logger logger = LoggerFactory.getLogger(AssetEntryServiceImpl.class);
	
	@Autowired
	private ClassesDao classesDao;
	
	public void addClasses(Class<?> clazz) throws SystemException{
		
		try {
			Classes classes = classesDao.findByClassName(clazz.getName());
			if(classes!=null){
				System.out.println("Class entry exist in Classes_" + clazz.getName());
			}else{
				Classes entry = new Classes();
				entry.setClassName(clazz.getName());
				entry.setCurrentId(1l);
				classesDao.save(entry);
			}
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}

}
