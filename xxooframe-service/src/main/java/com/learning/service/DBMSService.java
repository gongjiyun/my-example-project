package com.learning.service;

import java.util.List;

import com.learning.common.model.TableVO;

public interface DBMSService {
	public List<String> searchAllTables();
	public TableVO getTableInfo(String table);
}
