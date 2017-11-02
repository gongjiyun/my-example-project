package com.xxooframe.utils.exception;

public class SystemException extends Exception {
	/**
	 * 
	 */
	private final static long serialVersionUID = 1L;
	private String errorCode;

	public SystemException(Exception e) {
		super(e);
		this.errorCode = "";
	}

	public SystemException(String code, String msg) {
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
