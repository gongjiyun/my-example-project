package com.xxooframe.dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.xxooframe.common.entities.CodeMaster;xxooframeport com.xxooframe.common.model.PageCrixxooframeia;
import com.xxooframe.common.modelxxooframegeResult;
import com.xxooframe.daxxooframebstractBaseDao;
import com.xxooxxooframeme.dao.CodeMasterDao;
import com.xxooframe.utils.util.QueryUtil;


@Repository("codeMasterDao")
public class CodeMasterDaoImpl extends AbstractBaseDao implements CodeMasterDao{

	@SuppressWarnings("unchecked")
	public List<CodeMaster> load(int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		return crit.list();
	}

	public CodeMaster findByPrimaryKey(long primaryKey) throws Exception{
		return getHibernateTemplate().get(CodeMaster.class, primaryKey);
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByDetachedCriteria(DetachedCriteria criteria) throws Exception{
		List<CodeMaster> list = (List<CodeMaster>) getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

	public List<CodeMaster> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception{
		return null;
	}

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception{
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByColumn(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		for(int i=0; i<cloumnNames.length; i++){
			String cloumnName = cloumnNames[i];
			if(i<values.length){
				crit.add(Restrictions.eq(cloumnName, values[i]));
			}
		}
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByColumn(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByColumns(String[] cloumnNames, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		for(int i=0; i<cloumnNames.length; i++){
			String cloumnName = cloumnNames[i];
			if(i<values.length){
				crit.add(Restrictions.eq(cloumnName, values[i]));
			}
		}
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByColumnLike(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<CodeMaster> findByInColumn(String cloumnName, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(CodeMaster.class);
		crit.add(Restrictions.in(cloumnName, values));
		return crit.list();
	}

	public Long save(CodeMaster entity) throws Exception{
		return (Long) getHibernateTemplate().save(entity);
	}

	public void update(CodeMaster entity) throws Exception{
		getHibernateTemplate().update(entity);
	}

	public void delete(CodeMaster entity) throws Exception{
		getHibernateTemplate().delete(entity);
	}

	public void delete(long primaryKey) throws Exception{
		CodeMaster codeMaster = getHibernateTemplate().get(CodeMaster.class, primaryKey);
		getHibernateTemplate().delete(codeMaster);
	}

}