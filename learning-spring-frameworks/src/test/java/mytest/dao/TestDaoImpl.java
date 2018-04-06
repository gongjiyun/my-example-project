package mytest.dao;

import java.util.List;

import org.hibernate.criterion.DetachedCriteria;
import org.springframework.stereotype.Repository;

import com.learning.common.entities.AuditLog;

@Repository("testDao")
public class TestDaoImpl extends BaseDao implements TestDao {

	@Override
	public long insertAuditLog(AuditLog auditLog) throws Exception {
		return (Long)this.getHibernateTemplate().save(auditLog);
	}

	@Override
	@SuppressWarnings("unchecked")
	public List<AuditLog> loadData() throws Exception {
		DetachedCriteria criteria = DetachedCriteria.forClass(AuditLog.class);
		List<AuditLog> list = (List<AuditLog>) getHibernateTemplate().findByCriteria(criteria);
		return list;
	}

}
