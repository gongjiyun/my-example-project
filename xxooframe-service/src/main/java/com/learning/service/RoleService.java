package com.learning.service;

import java.util.List;

import com.learning.common.entities.Role;
import com.learning.utils.exception.SystemException;

public interface RoleService {
	
	public List<Role> loadRoles() throws SystemException;
	
	public Role findRoleById(long roleId) throws SystemException;
	
	public Role findRoleByName(String name) throws SystemException;
	
	public List<Role> findPortalRoles() throws SystemException;
	
	public long save(Role role) throws SystemException;
	
	public void update(Role role) throws SystemException;
}
