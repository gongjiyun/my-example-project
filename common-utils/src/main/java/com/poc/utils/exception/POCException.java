package com.poc.utils.exception;

public class POCException extends Exception {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	public POCException(Exception e){
		super(e);
		this.errorMsg = e.getMessage();
	}
	public POCException(String msg){
		super(msg);
		this.errorMsg = msg;
	}
	
	private String errorCode;
	private String errorMsg;

	public String getErrorCode() {
		return errorCode;
	}
	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	public String getErrorMsg() {
		return errorMsg;
	}
	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
}
