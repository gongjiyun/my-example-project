package com.xxooframe.utils.exception;

public class RemoteServiceException extends Exception {
	/**
	 * 
	 */
	private final static long serialVersionUID = 1L;
	private String errorCode;

	public RemoteServiceException(Exception e) {
		super(e);
	}

	public RemoteServiceException(String e) {
		super(e);
	}

	public RemoteServiceException(String code, String msg) {
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
