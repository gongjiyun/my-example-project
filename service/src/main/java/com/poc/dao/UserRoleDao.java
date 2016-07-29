package com.poc.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;

import com.poc.common.entities.UserRole;
import com.poc.common.model.PageCriteria;
import com.poc.common.model.PageResult;


public interface UserRoleDao extends IBaseDao{
	public List<UserRole> load(int start, int end) throws Exception;

	public UserRole findByPrimaryKey(long primaryKey) throws Exception;

	public List<UserRole> findByDetachedCriteria(DetachedCriteria criteria) throws Exception;

	public List<UserRole> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception;

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception;

	public List<UserRole> findByColumn(String cloumnName, Object value, int start, int end) throws Exception;

	public List<UserRole> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception;

	public List<UserRole> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception;

	public List<UserRole> findByColumn(String cloumnName, Object value) throws Exception;

	public List<UserRole> findByColumns(String[] cloumnNames, Object[] values) throws Exception;

	public List<UserRole> findByColumnLike(String cloumnName, Object value) throws Exception;

	public List<UserRole> findByInColumn(String cloumnName, Object[] values) throws Exception;

	public Long save(UserRole entity) throws Exception;

	public void update(UserRole entity) throws Exception;

	public void delete(UserRole entity) throws Exception;

	public void delete(long primaryKey) throws Exception;

}