package com.poc.service.impl;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.poc.common.entities.CodeMaster;
import com.poc.dao.CodeMasterDao;
import com.poc.service.AbstractBaseService;
import com.poc.service.CodeService;
import com.poc.utils.constants.TableDefConstants;
import com.poc.utils.exception.SystemException;

/**
 **Digital Banking Trends ¨C Banks¡¯ Goal and NCS Presence
 **/
@Service("codeService")
public class CodeServiceImpl extends AbstractBaseService implements CodeService {

	@Autowired
	private CodeMasterDao codeMasterDao;
	
	public List<CodeMaster> loadCodes(String type) throws SystemException {
		try {
			DetachedCriteria criteria=DetachedCriteria.forClass(CodeMaster.class);
			criteria.add(Restrictions.eq(TableDefConstants.CodeMaster.type.name(), type));
			return codeMasterDao.findByDetachedCriteria(criteria);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}

	public CodeMaster findCode(String codeKey, String type) throws SystemException {
		try {
			DetachedCriteria criteria=DetachedCriteria.forClass(CodeMaster.class);
			criteria.add(Restrictions.eq(TableDefConstants.CodeMaster.type.name(), type));
			criteria.add(Restrictions.eq(TableDefConstants.CodeMaster.codeKey.name(), codeKey));
			List<CodeMaster> list = codeMasterDao.findByDetachedCriteria(criteria);
			if(list!=null && list.size()>0){
				return list.get(0);
			}
			return null;
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}

	public long saveCode(CodeMaster codeMaster) throws SystemException{
		try {
			return codeMasterDao.save(codeMaster);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public void updateCode(CodeMaster codeMaster) throws SystemException{
		try {
			codeMasterDao.update(codeMaster);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
	
	public void deleteCode(long codeMasterId) throws SystemException{
		try {
			codeMasterDao.delete(codeMasterId);
		} catch (Exception e) {
			throw new SystemException(e);
		}
	}
}
