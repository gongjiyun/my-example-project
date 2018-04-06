package com.learning.service;

import java.util.List;

import com.learning.common.entities.CodeMaster;
import com.learning.utils.exception.SystemException;

public interface CodeService {
	
	public List<CodeMaster> loadCodes(String type) throws SystemException;
	
	public CodeMaster findCode(String codeKey, String type) throws SystemException;
	
	public long saveCode(CodeMaster codeMaster) throws SystemException;
	
	public void updateCode(CodeMaster codeMaster) throws SystemException;
	
	public void deleteCode(long codeMasterId) throws SystemException;
}
