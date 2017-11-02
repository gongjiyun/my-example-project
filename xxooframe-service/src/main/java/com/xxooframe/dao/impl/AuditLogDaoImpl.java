package com.xxooframe.dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.xxooframe.common.entities.AuditLog;
import com.xxooframe.common.model.PageCriteria;
import com.xxooframe.common.model.PageResult;
import com.xxooframe.dao.AbstractBaseDao;
import com.xxooframe.dao.AuditLogDao;
import com.xxooframe.utils.util.QueryUtil;


@Repository("auditLogDao")
public class AuditLogDaoImpl extends AbstractBaseDao implements AuditLogDao{

	@SuppressWarnings("unchecked")
	public List<AuditLog> load(int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		return crit.list();
	}

	public AuditLog findByPrimaryKey(long primaryKey) throws Exception{
		return getHibernateTemplate().get(AuditLog.class, primaryKey);
	}

	@SuppressWarnings("unchecked")
	public List<AuditLog> findByDetachedCriteria(DetachedCriteria criteria) throws Exception{
		List<AuditLog> list = (List<AuditLog>) getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

	public List<AuditLog> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception{
		return null;
	}

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception{
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<AuditLog> findByColumn(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<AuditLog> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
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
	public List<AuditLog> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<AuditLog> findByColumn(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<AuditLog> findByColumns(String[] cloumnNames, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
		for(int i=0; i<cloumnNames.length; i++){
			String cloumnName = cloumnNames[i];
			if(i<values.length){
				crit.add(Restrictions.eq(cloumnName, values[i]));
			}
		}
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<AuditLog> findByColumnLike(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<AuditLog> findByInColumn(String cloumnName, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(AuditLog.class);
		crit.add(Restrictions.in(cloumnName, values));
		return crit.list();
	}

	public Long save(AuditLog entity) throws Exception{
		return (Long) getHibernateTemplate().save(entity);
	}

	public void update(AuditLog entity) throws Exception{
		getHibernateTemplate().update(entity);
	}

	public void delete(AuditLog entity) throws Exception{
		getHibernateTemplate().delete(entity);
	}

	public void delete(long primaryKey) throws Exception{
		AuditLog auditLog = getHibernateTemplate().get(AuditLog.class, primaryKey);
		getHibernateTemplate().delete(auditLog);
	}

}