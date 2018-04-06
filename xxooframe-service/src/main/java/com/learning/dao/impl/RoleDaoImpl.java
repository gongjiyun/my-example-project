package com.learning.dao.impl;

import java.util.List;
import java.util.Map;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.learning.common.entities.Role;
import com.learning.common.model.PageCriteria;
import com.learning.common.model.PageResult;
import com.learning.dao.AbstractBaseDao;
import com.learning.dao.RoleDao;
import com.learning.utils.util.QueryUtil;


@Repository("roleDao")
public class RoleDaoImpl extends AbstractBaseDao implements RoleDao{

	@SuppressWarnings("unchecked")
	public List<Role> load(int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		return crit.list();
	}

	public Role findByPrimaryKey(long primaryKey) throws Exception{
		return getHibernateTemplate().get(Role.class, primaryKey);
	}

	@SuppressWarnings("unchecked")
	public List<Role> findByDetachedCriteria(DetachedCriteria criteria) throws Exception{
		List<Role> list = (List<Role>) getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

	public List<Role> findByParameterMap(Map<String, Object> parameter, int start, int end) throws Exception{
		return null;
	}

	public PageResult<?> searchPageResults(PageCriteria pageCriteria) throws Exception{
		return null;
	}

	@SuppressWarnings("unchecked")
	public List<Role> findByColumn(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Role> findByColumns(String[] cloumnNames, Object[] values, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
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
	public List<Role> findByColumnLike(String cloumnName, Object value, int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Role> findByColumn(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
		crit.add(Restrictions.eq(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Role> findByColumns(String[] cloumnNames, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
		for(int i=0; i<cloumnNames.length; i++){
			String cloumnName = cloumnNames[i];
			if(i<values.length){
				crit.add(Restrictions.eq(cloumnName, values[i]));
			}
		}
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Role> findByColumnLike(String cloumnName, Object value) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
		crit.add(Restrictions.like(cloumnName, value));
		return crit.list();
	}

	@SuppressWarnings("unchecked")
	public List<Role> findByInColumn(String cloumnName, Object[] values) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(Role.class);
		crit.add(Restrictions.in(cloumnName, values));
		return crit.list();
	}

	public Long save(Role entity) throws Exception{
		return (Long) getHibernateTemplate().save(entity);
	}

	public void update(Role entity) throws Exception{
		getHibernateTemplate().update(entity);
	}

	public void delete(Role entity) throws Exception{
		getHibernateTemplate().delete(entity);
	}

	public void delete(long primaryKey) throws Exception{
		Role role = getHibernateTemplate().get(Role.class, primaryKey);
		getHibernateTemplate().delete(role);
	}

}