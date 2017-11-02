package com.xxooframe.service;

import com.xxooframe.utils.exception.SystemException;

public interface AssetEntryService extends IBaseService{
	public void addClasses(Class<?> clazz) throws SystemException;
}
