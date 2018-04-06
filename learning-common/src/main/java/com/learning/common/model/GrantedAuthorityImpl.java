package com.learning.common.model;

import org.springframework.security.core.GrantedAuthority;

public class GrantedAuthorityImpl implements GrantedAuthority {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String authority;
	
	public GrantedAuthorityImpl(String authority){
		this.authority = authority;
	}
	
	public String getAuthority() {
		return this.authority;
	}

}
