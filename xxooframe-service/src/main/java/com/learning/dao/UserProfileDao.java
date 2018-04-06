package com.learning.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;

import com.learning.common.entities.UserProfile;
import com.learning.common.model.PageCriteria;
import com.learning.common.model.PageResult;


public interface UserProfileDao extends IBaseDao{
	public List<UserProfile> load(int start, int end) throws Exception;

	public UserProfile findByPrimaryKey(long primaryKey) throws Exception;

	public List<UserProfile> findByDetachedCriteria(DetachedCriteria criteria) throws Exception;

	public List<UserProfile> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception;

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception;

	public List<UserProfile> findByColumn(String cloumnName, Object value, int start, int end) throws Exception;

	public List<UserProfile> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception;

	public List<UserProfile> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception;

	public List<UserProfile> findByColumn(String cloumnName, Object value) throws Exception;

	public List<UserProfile> findByColumns(String[] cloumnNames, Object[] values) throws Exception;

	public List<UserProfile> findByColumnLike(String cloumnName, Object value) throws Exception;

	public List<UserProfile> findByInColumn(String cloumnName, Object[] values) throws Exception;

	public Long save(UserProfile entity) throws Exception;

	public void update(UserProfile entity) throws Exception;

	public void delete(UserProfile entity) throws Exception;

	public void delete(long primaryKey) throws Exception;

}