package com.learning.service;

import java.util.List;

import com.learning.common.entities.Role;
import com.learning.common.entities.User;
import com.learning.common.entities.UserProfile;
import com.learning.common.entities.UserRole;
import com.learning.common.model.PageCriteria;
import com.learning.utils.exception.SystemException;
import com.learning.utils.util.PortalContext;

public interface UserService extends IBaseService{
	
	public List<User> loadUsers() throws SystemException;
	
	public List<User> searchUsers(PageCriteria searchCriteria) throws SystemException;
	
	public List<User> loadUsersByRole(String roleName) throws SystemException;
	
	public User findUserById(long id) throws SystemException;
	
	public User findUserByName(String name) throws SystemException;
	
	public List<User> findUserByRoleId(long roleId) throws SystemException;
	
	public List<Role> findRolesByUID(long uid) throws SystemException;
	
	public List<UserRole> findUserRolesByUID(long uid) throws SystemException;
	
	public long createUser(User user, long[] roleIds, UserProfile profile, PortalContext portalContext) throws SystemException;
	
	public long createPortalUser(User user, long[] roleIds, UserProfile profile, PortalContext portalContext) throws SystemException;
	
	public void updateUser(User user, long[] roleIds, UserProfile profile, PortalContext portalContext) throws SystemException;
	
	public void deleteUser(User user, PortalContext portalContext) throws SystemException;
	
	public void activeUser(User user, PortalContext portalContext) throws SystemException;
	
	public void inactiveUser(User user, PortalContext portalContext) throws SystemException;
	
	public UserProfile findUserProfileByUID(long uid) throws SystemException;
	
	public void updateProfile(UserProfile profile) throws SystemException;
	
	public void createUserRoles(User user, long[] roleIds) throws SystemException;
	
	public void updateUserRoles(User user, long[] roleIds) throws SystemException;
	
	public boolean changePassword(String username, String password) throws SystemException;

}
