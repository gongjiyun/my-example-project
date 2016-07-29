package com.poc.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;

import com.poc.common.entities.AuditLog;
import com.poc.common.model.PageCriteria;
import com.poc.common.model.PageResult;


public interface AuditLogDao extends IBaseDao{
	public List<AuditLog> load(int start, int end) throws Exception;

	public AuditLog findByPrimaryKey(long primaryKey) throws Exception;

	public List<AuditLog> findByDetachedCriteria(DetachedCriteria criteria) throws Exception;

	public List<AuditLog> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception;

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception;

	public List<AuditLog> findByColumn(String cloumnName, Object value, int start, int end) throws Exception;

	public List<AuditLog> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception;

	public List<AuditLog> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception;

	public List<AuditLog> findByColumn(String cloumnName, Object value) throws Exception;

	public List<AuditLog> findByColumns(String[] cloumnNames, Object[] values) throws Exception;

	public List<AuditLog> findByColumnLike(String cloumnName, Object value) throws Exception;

	public List<AuditLog> findByInColumn(String cloumnName, Object[] values) throws Exception;

	public Long save(AuditLog entity) throws Exception;

	public void update(AuditLog entity) throws Exception;

	public void delete(AuditLog entity) throws Exception;

	public void delete(long primaryKey) throws Exception;

}