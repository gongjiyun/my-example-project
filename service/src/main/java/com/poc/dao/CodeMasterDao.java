package com.poc.dao;

import java.util.List;
import java.util.Map;

import org.hibernate.criterion.DetachedCriteria;

import com.poc.common.entities.CodeMaster;
import com.poc.common.model.PageCriteria;
import com.poc.common.model.PageResult;


public interface CodeMasterDao extends IBaseDao{
	public List<CodeMaster> load(int start, int end) throws Exception;

	public CodeMaster findByPrimaryKey(long primaryKey) throws Exception;

	public List<CodeMaster> findByDetachedCriteria(DetachedCriteria criteria) throws Exception;

	public List<CodeMaster> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception;

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception;

	public List<CodeMaster> findByColumn(String cloumnName, Object value, int start, int end) throws Exception;

	public List<CodeMaster> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception;

	public List<CodeMaster> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception;

	public List<CodeMaster> findByColumn(String cloumnName, Object value) throws Exception;

	public List<CodeMaster> findByColumns(String[] cloumnNames, Object[] values) throws Exception;

	public List<CodeMaster> findByColumnLike(String cloumnName, Object value) throws Exception;

	public List<CodeMaster> findByInColumn(String cloumnName, Object[] values) throws Exception;

	public Long save(CodeMaster entity) throws Exception;

	public void update(CodeMaster entity) throws Exception;

	public void delete(CodeMaster entity) throws Exception;

	public void delete(long primaryKey) throws Exception;

}