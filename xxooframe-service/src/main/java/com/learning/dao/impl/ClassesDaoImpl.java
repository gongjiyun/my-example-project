package com.learning.dao.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.stereotype.Repository;

import com.learning.common.entities.Classes;
import com.learning.dao.AbstractBaseDao;
import com.learning.dao.ClassesDao;

@Repository("classesDao")
public class ClassesDaoImpl extends AbstractBaseDao implements ClassesDao {

	public Classes findByPrimaryKey(String primaryKey) throws Exception {
		return getHibernateTemplate().get(Classes.class, primaryKey);
	}

	@SuppressWarnings("unchecked")
	public Classes findByClassName(String className) throws Exception {
		DetachedCriteria criteria=DetachedCriteria.forClass(Classes.class);
		criteria.add(Restrictions.eq("className", className));
		List<Classes> list = (List<Classes>) getHibernateTemplate().findByCriteria(criteria);
		if(list==null || list.size()==0){
			return null;
		}
		return list.get(0);
	}

	public synchronized String save(Classes entity) throws Exception {
		return (String) getHibernateTemplate().save(entity);
	}

	public synchronized  void update(Classes entity) throws Exception {
		getHibernateTemplate().update(entity);
	}

	public synchronized void delete(Classes entity) throws Exception {
		getHibernateTemplate().delete(entity);
	}

	public synchronized void delete(String primaryKey) throws Exception {
		Classes clazz = getHibernateTemplate().get(Classes.class, primaryKey);
		getHibernateTemplate().delete(clazz);
	}

	public synchronized Long generateNextId(Class<?> entity) throws Exception {
		long currentid = 1;
		Classes clazz = findByClassName(entity.getName());
		if(clazz==null){
			Classes nclass = new Classes();
			nclass.setClassName(entity.getName());
			nclass.setCurrentId(currentid);
			getHibernateTemplate().save(nclass);
			return new Long(1);
		}else{
			currentid = clazz.getCurrentId() + 1;
			clazz.setCurrentId(currentid);
			getHibernateTemplate().update(clazz);
		}
		return currentid;
	}

}
