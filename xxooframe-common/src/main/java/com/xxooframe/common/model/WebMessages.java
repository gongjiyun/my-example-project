package com.xxooframe.common.model;


import java.util.ArrayList;
import java.util.List;

/**
 **Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
public class WebMessages {
	
	private List<WebMessage> errors = new ArrayList<WebMessage>();
	
	public void addError(WebMessage error){
		this.errors.add(error);
	}
	
	public List<WebMessage> getErrors(){
		return this.errors;
	}
	
	public void clearErrors(){
		this.errors.clear();
	}
}
