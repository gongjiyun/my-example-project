package com.learning.dao;

import com.learning.common.entities.Classes;

public interface ClassesDao {

	public Classes findByPrimaryKey(String primaryKey) throws Exception;
	
	public Classes findByClassName(String className) throws Exception;
	
	public Long generateNextId(Class<?> entity) throws Exception;

	public String save(Classes entity) throws Exception;

	public void update(Classes entity) throws Exception;

	public void delete(Classes entity) throws Exception;

	public void delete(String primaryKey) throws Exception;
}
