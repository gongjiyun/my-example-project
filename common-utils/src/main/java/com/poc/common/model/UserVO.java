package com.poc.common.model;

import java.util.List;

import com.poc.common.entities.Role;
import com.poc.common.entities.User;
import com.poc.common.entities.UserProfile;


public class UserVO{
	private long uid;
	private String username;	
	private String password;
	private String email;
	private String roleIds;
	private String status;
	private User user;
	private UserProfile userProfile;
	private List<Role> roles;
	private String remarks;
	private String roleDescriptions;

	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public long getUid() {
		return uid;
	}
	public void setUid(long uid) {
		this.uid = uid;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public UserProfile getUserProfile() {
		return userProfile;
	}
	public void setUserProfile(UserProfile userProfile) {
		this.userProfile = userProfile;
	}
	public List<Role> getRoles() {
		return roles;
	}
	public void setRoles(List<Role> roles) {
		this.roles = roles;
	}
	public String getRoleDescriptions() {
		return roleDescriptions;
	}
	public void setRoleDescriptions(String roleDescriptions) {
		this.roleDescriptions = roleDescriptions;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getRoleIds() {
		return roleIds;
	}
	public void setRoleIds(String roleIds) {
		this.roleIds = roleIds;
	}
	public String getRemarks() {
		return remarks;
	}
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}
