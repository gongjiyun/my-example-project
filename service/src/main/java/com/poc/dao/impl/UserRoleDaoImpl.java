package com.poc.dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.poc.common.entities.UserRole;
import com.poc.common.model.PageCriteria;
import com.poc.common.model.PageResult;
import com.poc.dao.AbstractBaseDao;
import com.poc.dao.UserRoleDao;
import com.poc.utils.util.QueryUtil;


@Repository("userRoleDao")
public class UserRoleDaoImpl extends AbstractBaseDao implements UserRoleDao{

	@SuppressWarnings("unchecked")
	public List<UserRole> load(int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		return crit.list();
	}

	public UserRole findByPrimaryKey(long primaryKey) throws Exception{
		return getHibernateTemplate().get(UserRole.class, primaryKey);
	}

	@SuppressWarnings("unchecked")
	public List<UserRole> findByDetachedCriteria(DetachedCriteria criteria) throws Exception{
		List<UserRole> list = (List<UserRole>) getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

	public List<UserRole> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception{
		return null;
	}

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception{
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<UserRole> findByColumn(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserRole> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
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
	public List<UserRole> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserRole> findByColumn(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserRole> findByColumns(String[] cloumnNames, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
		for(int i=0; i<cloumnNames.length; i++){
			String cloumnName = cloumnNames[i];
			if(i<values.length){
				crit.add(Restrictions.eq(cloumnName, values[i]));
			}
		}
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserRole> findByColumnLike(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserRole> findByInColumn(String cloumnName, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserRole.class);
		crit.add(Restrictions.in(cloumnName, values));
		return crit.list();
	}

	public Long save(UserRole entity) throws Exception{
		return (Long) getHibernateTemplate().save(entity);
	}

	public void update(UserRole entity) throws Exception{
		getHibernateTemplate().update(entity);
	}

	public void delete(UserRole entity) throws Exception{
		getHibernateTemplate().delete(entity);
	}

	public void delete(long primaryKey) throws Exception{
		UserRole userRole = getHibernateTemplate().get(UserRole.class, primaryKey);
		getHibernateTemplate().delete(userRole);
	}

}