package com.poc.service;

import com.poc.utils.exception.SystemException;

public interface AssetEntryService extends IBaseService{
	public void addClasses(Class<?> clazz) throws SystemException;
}
