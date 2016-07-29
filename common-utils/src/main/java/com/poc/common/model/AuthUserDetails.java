package com.poc.common.model;

import java.util.Collection;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;

public class AuthUserDetails implements UserDetails {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private long uid;
	private String username;
	private String password;
	private boolean enable;
	private Collection<? extends GrantedAuthority> authorities;
	
	public AuthUserDetails(long uid, String username, String password, boolean enable, Collection<? extends GrantedAuthority> authorities){
		this.uid = uid;
		this.username = username;
		this.password = password;
		this.enable = enable;
		this.authorities = authorities;
	}

	public Collection<? extends GrantedAuthority> getAuthorities() {
		return this.authorities;
	}

	public String getPassword() {
		return this.password;
	}

	public long getUid() {
		return this.uid;
	}
	
	public String getUsername() {
		return this.username;
	}

	public boolean isAccountNonExpired() {
		return true;
	}

	public boolean isAccountNonLocked() {
		return true;
	}

	public boolean isCredentialsNonExpired() {
		return true;
	}

	public boolean isEnabled() {
		return this.enable;
	}

}
