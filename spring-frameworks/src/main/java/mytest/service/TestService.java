package mytest.service;

public interface TestService {
	
	public String getValue();
	
	public void process(String source) throws Exception;
	
	public void insertTestData() throws Exception;
}
