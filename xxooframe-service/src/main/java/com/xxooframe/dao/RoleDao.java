package com.xxooframe.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;

import com.xxooframe.common.entities.Role;xxooframeport com.xxooframe.common.model.PageCrixxooframeia;
import com.xxooframe.common.model.PageResult;


public interface RoleDao extends IBaseDao{
	public List<Role> load(int start, int end) throws Exception;

	public Role findByPrimaryKey(long primaryKey) throws Exception;

	public List<Role> findByDetachedCriteria(DetachedCriteria criteria) throws Exception;

	public List<Role> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception;

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception;

	public List<Role> findByColumn(String cloumnName, Object value, int start, int end) throws Exception;

	public List<Role> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception;

	public List<Role> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception;

	public List<Role> findByColumn(String cloumnName, Object value) throws Exception;

	public List<Role> findByColumns(String[] cloumnNames, Object[] values) throws Exception;

	public List<Role> findByColumnLike(String cloumnName, Object value) throws Exception;

	public List<Role> findByInColumn(String cloumnName, Object[] values) throws Exception;

	public Long save(Role entity) throws Exception;

	public void update(Role entity) throws Exception;

	public void delete(Role entity) throws Exception;

	public void delete(long primaryKey) throws Exception;

}