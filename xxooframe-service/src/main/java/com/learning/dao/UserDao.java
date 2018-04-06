package com.learning.dao;

import java.util.List;

import com.learning.common.entities.Role;
import com.learning.common.entities.User;
import com.learning.common.entities.UserRole;

public interface UserDao {
	
	public List<User> loadUsers(int start, int end) throws Exception;
	
	public List<User> findRemoteUsers() throws Exception;
	
	public User findUserById(long id) throws Exception;
	
	public User findUserByName(String name) throws Exception;
	
	public long createUser(User user) throws Exception;
	
	public void deleteUser(User user) throws Exception;
	
	public long updateUser(User user) throws Exception;
	
	public long createUserRole(UserRole userRole) throws Exception;
	
	public void updateUserRole(UserRole userRole) throws Exception;
	
	public void updatePassword(User user) throws Exception;
	
	public List<Role> findRolesByUID(long uid) throws Exception;	
	
	public List<UserRole> findUserRolesByUID(long uid) throws Exception;	
}
