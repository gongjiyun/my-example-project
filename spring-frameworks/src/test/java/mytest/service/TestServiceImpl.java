package mytest.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.Reader;

import mytest.dao.TestDao;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.xxooframe.common.entities.AuditLog;
import com.xxooframe.utils.util.DateUtil;

@Component
@Transactional
@Service("testService")
public class TestServiceImpl implements TestService{
	
	//@Value("#{config['DEFAULT.linux.host']}")
	@Value("${jdbc.url}")
	private String value;

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	
	@Autowired
	private TestDao testDao;

	public TestDao getTestDao() {
		return testDao;
	}

	public void setTestDao(TestDao testDao) {
		this.testDao = testDao;
	}

	@Override
	public void process(String source) throws Exception {
		System.out.println("Process *********************************");
	}

	@Override
	public void insertTestData() throws Exception {
		long start = System.currentTimeMillis();
		Reader reader = new FileReader(new File("/Projects/TestData/access_2013_05_31.log"));
		BufferedReader bfreader = new BufferedReader(reader);
		String line = null;
		long count = 0;
		while((line = bfreader.readLine())!=null){
			if(count==1000){
				break;
			}
			try {				
				String[] logs = line.split(" - - ");
				String ip = logs[0].trim();
				
				int timestart = logs[1].indexOf("[");
				int timeend = logs[1].indexOf("]");
				int urlstart = logs[1].indexOf("\"");
				int urlend = logs[1].lastIndexOf("\"");
				String timestr = logs[1].substring(timestart+1, timeend);

				String urlstr = logs[1].substring(urlstart+1, urlend);

				String method = urlstr.split(" ")[0];
				String uri = urlstr.split(" ")[1];
				String protocl = urlstr.split(" ")[2];
				
				AuditLog auditLog = new AuditLog();
				auditLog.setCreatedBy((long)0);
				auditLog.setCreatedDate(DateUtil.parseDate(timestr, "dd/MMM/yyyy:HH:mm:ss"));
				auditLog.setIp(ip);
				auditLog.setMethod(method);
				auditLog.setUri(uri);

				testDao.insertAuditLog(auditLog);
			} catch (Exception e) {
				System.err.println(e);
			}
			count++;
		}
		bfreader.close();
		
		long end = System.currentTimeMillis();
		System.out.println("Take time = " + (end - start)/(60*1000));
	}
	
	public static void main(String[] args) {
		String requestLogStr = "60.164.35.90 - - [31/May/2013:00:00:10 +0800] \"GET /home.php?mod=spacecp&ac=blog HTTP/1.1\" 200 15425";
		String[] logs = requestLogStr.split(" - - ");
		String ip = logs[0].trim();
		int timestart = logs[1].indexOf("[");
		int timeend = logs[1].indexOf("]");
		int urlstart = logs[1].indexOf("\"");
		int urlend = logs[1].lastIndexOf("\"");
		String timestr = logs[1].substring(timestart+1, timeend);
		System.out.println(timestr);
		String urlstr = logs[1].substring(urlstart+1, urlend);
		System.out.println(urlstr);
		String method = urlstr.split(" ")[0];
		String uri = urlstr.split(" ")[1];
		String protocl = urlstr.split(" ")[2];
		
		DateUtil.parseDate("31/May/2013:00:00:10 +0800", "dd/MMM/yyyy:HH:mm:ss Z");
		
	}
	
}
