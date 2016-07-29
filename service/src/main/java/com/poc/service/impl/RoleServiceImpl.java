package com.poc.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poc.common.entities.Role;
import com.poc.dao.RoleDao;
import com.poc.service.RoleService;
import com.poc.utils.constants.StatusConstants;
import com.poc.utils.constants.TableDefConstants;
import com.poc.utils.exception.SystemException;
import com.poc.utils.util.QueryUtil;

@Service("roleService")
public class RoleServiceImpl implements RoleService {
	private static final Logger logger = LoggerFactory.getLogger(RoleServiceImpl.class);
	
	@Autowired
	private RoleDao roleDao;

	public List<Role> loadRoles() throws SystemException{
		try {
			return roleDao.load(QueryUtil.ALL_POS, QueryUtil.ALL_POS);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public Role findRoleById(long roleId) throws SystemException{
		try {
			return roleDao.findByPrimaryKey(roleId);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public Role findRoleByName(String name) throws SystemException{
		try {
			List<Role> roles = roleDao.findByColumn(TableDefConstants.Role.name.name(), name);
			if(roles!=null && roles.size()>0){
				if(roles.size()>1){
					logger.info("WARNING:Role " + name + " more than one");
				}
				return roles.get(0);
			}
			return null;
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public List<Role> findPortalRoles() throws SystemException{
		try {
			DetachedCriteria criteria = DetachedCriteria.forClass(Role.class);
			criteria.add(Restrictions.eq(TableDefConstants.Role.display.name(), StatusConstants.DATA_STATUS_YES));
			criteria.addOrder(Order.asc(TableDefConstants.Role.displayOrder.name()));
			
			List<Role> roles = roleDao.findByDetachedCriteria(criteria);
			return roles;
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	
	public long save(Role role) throws SystemException{
		try {
			return roleDao.save(role);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public void update(Role role) throws SystemException{
		try {
			roleDao.update(role);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}

}
