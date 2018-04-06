package mytest.dao;

import java.util.List;

import com.learning.common.entities.AuditLog;

public interface TestDao {
	
	public long insertAuditLog(AuditLog auditLog) throws Exception;
	
	public List<AuditLog> loadData() throws Exception;

}
