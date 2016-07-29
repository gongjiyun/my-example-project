package com.poc.utils.exception;

public class AuthenticationException extends Exception {
	/**
	 * 
	 */
	private final static long serialVersionUID = 1L;
	private String errorCode;

	public AuthenticationException(Exception e) {
		super(e);
	}

	public AuthenticationException(String error) {
		super(error);
	}

	public AuthenticationException(String code, String msg) {
		super(msg);
		this.errorCode = code;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
}
