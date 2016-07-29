package mytest.spring;

import mytest.service.TestService;

import org.junit.Test;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

public class TestSpring {
	
	public static void main(String[] args) throws Exception{
		TestSpring test = new TestSpring();
		test.prepareTestData();
	}
	
	
	public void testSpring() throws Exception{
		TestService service = (TestService) StandloneSpringFactory.getContext().getBean("testService");
		service.process(null);
	}
	
	public void testSpringTransaction(){
		PlatformTransactionManager transMgr = new PlatformTransactionManager() {
			public void rollback(TransactionStatus arg0) throws TransactionException {
				System.out.println("rollback");
			}
			public TransactionStatus getTransaction(TransactionDefinition arg0)
					throws TransactionException {				
				System.out.println("getTransaction");
				return null;
			}
			
			public void commit(TransactionStatus arg0) throws TransactionException {
				System.out.println("commit");
			}
		};
		
		DefaultTransactionDefinition def =new DefaultTransactionDefinition();
		def.setName("transactionManager");
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		TransactionStatus status = transMgr.getTransaction(def);
		try{
			System.out.println("test");
			transMgr.commit(status);
		}catch(Exception e){
			e.printStackTrace();
			transMgr.rollback(status);
		}
	}

	@Test
	public void prepareTestData() throws Exception{
		TestService service = (TestService) StandloneSpringFactory.getContext().getBean("testService");
		service.insertTestData();
	}
}
