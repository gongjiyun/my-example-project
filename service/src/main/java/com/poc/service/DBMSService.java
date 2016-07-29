package com.poc.service;

import java.util.List;

import com.poc.common.model.TableVO;

public interface DBMSService {
	public List<String> searchAllTables();
	public TableVO getTableInfo(String table);
}
