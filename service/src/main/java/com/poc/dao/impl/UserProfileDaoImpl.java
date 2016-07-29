package com.poc.dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.poc.common.entities.UserProfile;
import com.poc.common.model.PageCriteria;
import com.poc.common.model.PageResult;
import com.poc.dao.AbstractBaseDao;
import com.poc.dao.UserProfileDao;
import com.poc.utils.util.QueryUtil;


@Repository("userProfileDao")
public class UserProfileDaoImpl extends AbstractBaseDao implements UserProfileDao{

	@SuppressWarnings("unchecked")
	public List<UserProfile> load(int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		return crit.list();
	}

	public UserProfile findByPrimaryKey(long primaryKey) throws Exception{
		return getHibernateTemplate().get(UserProfile.class, primaryKey);
	}

	@SuppressWarnings("unchecked")
	public List<UserProfile> findByDetachedCriteria(DetachedCriteria criteria) throws Exception{
		List<UserProfile> list = (List<UserProfile>) getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

	public List<UserProfile> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception{
		return null;
	}

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception{
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<UserProfile> findByColumn(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserProfile> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
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
	public List<UserProfile> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserProfile> findByColumn(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserProfile> findByColumns(String[] cloumnNames, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
		for(int i=0; i<cloumnNames.length; i++){
			String cloumnName = cloumnNames[i];
			if(i<values.length){
				crit.add(Restrictions.eq(cloumnName, values[i]));
			}
		}
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserProfile> findByColumnLike(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<UserProfile> findByInColumn(String cloumnName, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(UserProfile.class);
		crit.add(Restrictions.in(cloumnName, values));
		return crit.list();
	}

	public Long save(UserProfile entity) throws Exception{
		return (Long) getHibernateTemplate().save(entity);
	}

	public void update(UserProfile entity) throws Exception{
		getHibernateTemplate().update(entity);
	}

	public void delete(UserProfile entity) throws Exception{
		getHibernateTemplate().delete(entity);
	}

	public void delete(long primaryKey) throws Exception{
		UserProfile userProfile = getHibernateTemplate().get(UserProfile.class, primaryKey);
		getHibernateTemplate().delete(userProfile);
	}

}