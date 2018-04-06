package com.learning.common.model;

import java.util.HashMap;
import java.util.Map;

/**
 **Digital Banking Trends �C Banks�� Goal and NCS Presence
 **/
public class PageCriteria {
	
	private int currentPage;
	private int start;
	private int end;

	private Map<String, Object> parameters = new HashMap<String, Object>();
	
	public PageCriteria(){
	}
	
	public PageCriteria(int currentPage, int start, int end){
		this.currentPage = currentPage;
		this.start = start;
		this.end = end;
	}
	
	public void setParameter(String key, Object value){
		parameters.put(key, value);
	}
	
	public Object getParameter(String key){
		return parameters.get(key);
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public int getStart() {
		return start;
	}

	public void setStart(int start) {
		this.start = start;
	}

	public int getEnd() {
		return end;
	}

	public void setEnd(int end) {
		this.end = end;
	}

	public Map<String, Object> getParameters() {
		return parameters;
	}

	public void setParameters(Map<String, Object> parameters) {
		this.parameters = parameters;
	}
}
