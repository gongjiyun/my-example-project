package com.learning.service;

import com.learning.utils.exception.SystemException;

public interface AssetEntryService extends IBaseService{
	public void addClasses(Class<?> clazz) throws SystemException;
}
