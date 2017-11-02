package com.xxooframe.common.model;

import java.util.List;

/**
 **Digital Banking Trends �C Banks�� Goal and NCS Presence
 **/
public class PageResult<T> {
	
	private int currentPage;
	private int pageSize;
	private int start;
	private int end;
	private List<?> result;
	
	public PageResult(List<?> result){
		this.result = result;
	}
	
	public int getCurrentPage() {
		return currentPage;
	}
	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
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
	public List<?> getResult() {
		return result;
	}
	public void setResult(List<?> result) {
		this.result = result;
	}
	
	

}
