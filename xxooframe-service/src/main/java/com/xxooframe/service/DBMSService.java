package com.xxooframe.service;

import java.util.List;

import com.xxooframe.common.model.TableVO;

public interface DBMSService {
	public List<String> searchAllTables();
	public TableVO getTableInfo(String table);
}
