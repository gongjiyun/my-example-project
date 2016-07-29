package com.poc.common.model;

/**
 ** Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public class WebMessage {

	private String msgKey;
	private boolean isError;
	private String[] args;
	private String message;

	public String getMsgKey() {
		return msgKey;
	}

	public void setMsgKey(String msgKey) {
		this.msgKey = msgKey;
	}

	public boolean isError() {
		return isError;
	}

	public void setError(boolean isError) {
		this.isError = isError;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String[] getArgs() {
		return args;
	}

	public void setArgs(String[] args) {
		this.args = args;
	}

}
