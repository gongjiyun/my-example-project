package com.poc.web.auth;

import java.security.Principal;

public class SamplePrincipal implements Principal {
	private String name;

	public SamplePrincipal(String name) {
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public boolean equals(Object o) {
		return (o instanceof SamplePrincipal)
				&& this.name.equalsIgnoreCase(((SamplePrincipal) o).name);
	}

	public int hashCode() {
		return name.toUpperCase().hashCode();
	}
}
