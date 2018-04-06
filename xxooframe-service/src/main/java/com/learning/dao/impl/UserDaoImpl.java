package com.learning.dao.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.learning.common.entities.Role;
import com.learning.common.entities.User;
import com.learning.common.entities.UserRole;
import com.learning.dao.AbstractBaseDao;
import com.learning.dao.UserDao;
import com.learning.utils.constants.TableDefConstants;
import com.learning.utils.util.QueryUtil;

@Repository("userDao")
public class UserDaoImpl extends AbstractBaseDao implements UserDao {
	private final static Logger logger = LoggerFactory.getLogger(UserDaoImpl.class);
	
	@SuppressWarnings("unchecked")
	public List<User> loadUsers(int start, int end) throws Exception{
		SessionFactory sf = getHibernateTemplate().getSessionFactory();
		Session session = sf.getCurrentSession();
		Criteria crit = session.createCriteria(User.class);
		if(start!=QueryUtil.ALL_POS && end!=QueryUtil.ALL_POS){
			crit.setFirstResult(start);
			crit.setMaxResults(end-start);
		}
		return crit.list();
	}
	
	@SuppressWarnings("unchecked")
	public List<User> findRemoteUsers() throws Exception{
		return null;
	}
	
	public User findUserById(long id) throws Exception{
		return getHibernateTemplate().get(User.class, id);
	}
	
	@SuppressWarnings("unchecked")
	public User findUserByName(String name) throws Exception {
		try {
			logger.info("find user by " + name);
			
			SessionFactory sf = getHibernateTemplate().getSessionFactory();
			Session session = sf.getCurrentSession();
			
			Criteria crit = session.createCriteria(User.class);
			crit.add(Restrictions.eq("username", name));
			
			List<User> list = crit.list();
			
			if(list!=null && list.size()>0){
				return list.get(0);
			}
		} catch (Exception e) {
			e.printStackTrace();
			throw new Exception(e);
		}
		return null;
	}

	public long createUser(User user) throws Exception {
		User exist = findUserByName(user.getUsername());
		if(exist!=null){
			throw new Exception("already exist user with name " + user.getUsername());
		}
		return (Long) getHibernateTemplate().save(user);
	}
	
	public long createUserRole(UserRole userRole) throws Exception{
		return (Long) getHibernateTemplate().save(userRole);
	}
	
	public void deleteUser(User user) throws Exception{
		getHibernateTemplate().delete(user);
	}
	
	public void updateUserRole(UserRole userRole) throws Exception{
		 getHibernateTemplate().update(userRole);
	}

	public long updateUser(User user) throws Exception {
		getHibernateTemplate().update(user);
		return user.getUid();
	}

	/*public long addUserLogin(UserLogin userLogin) throws Exception {
		return (Long) getHibernateTemplate().save(userLogin);
	}*/

	/*@SuppressWarnings("unchecked")
	public UserLogin getLastUserLoginByUid(long uid) throws Exception {
		UserLogin lllogin = null;
		DetachedCriteria criteria=DetachedCriteria.forClass(UserLogin.class);
		criteria.add(Restrictions.eq(TableDefConstants.UserLogin.uid.name(), uid));
		List<UserLogin> list = (List<UserLogin>) getHibernateTemplate().findByCriteria(criteria);
		if(list!=null && list.size()>0){
			Date lasttime = list.get(0).getLoginTime();
			lllogin = list.get(0);
			for(int i=0; i<list.size(); i++){
				Date ltime = list.get(i).getLoginTime();
				if(ltime!=null && ltime.compareTo(lasttime)>0){
					lasttime = ltime;
					lllogin = list.get(i);
				}
			}
		}
		return lllogin;
	}*/

	public void updatePassword(User user) throws Exception {
		getHibernateTemplate().update(user);
	}
	
	@SuppressWarnings("unchecked")
	public List<Role> findRolesByUID(long uid) throws Exception{
		List<Role> roles = new ArrayList<Role>();
		DetachedCriteria criteria=DetachedCriteria.forClass(UserRole.class);
		criteria.add(Restrictions.eq(TableDefConstants.UserRole.uid.name(), uid));
		List<UserRole> list = (List<UserRole>) getHibernateTemplate().findByCriteria(criteria);
		if(list!=null && list.size()>0){
			for(UserRole ur: list){
				Role ro = getHibernateTemplate().get(Role.class, ur.getRoleId());
				roles.add(ro);
			}
		}
		return roles;
	}
	
	@SuppressWarnings("unchecked")
	public List<UserRole> findUserRolesByUID(long uid) throws Exception{
		DetachedCriteria criteria=DetachedCriteria.forClass(UserRole.class);
		criteria.add(Restrictions.eq(TableDefConstants.UserRole.uid.name(), uid));
		List<UserRole> list = (List<UserRole>) getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

}
