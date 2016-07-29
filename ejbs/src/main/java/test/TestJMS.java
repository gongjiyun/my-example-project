/**
This class add by Administrator
 */
package test;

import java.util.Hashtable;

import javax.jms.Session;
import javax.jms.TextMessage;
import javax.jms.Topic;
import javax.jms.TopicConnection;
import javax.jms.TopicConnectionFactory;
import javax.jms.TopicPublisher;
import javax.jms.TopicSession;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;

public class TestJMS {
	private static final String context_fac = "weblogic.jndi.WLInitialContextFactory";
	private static final String url = "t3://localhost:7001";

	public static Context useContext() {
		try {
			Hashtable<String, String> env = new Hashtable<String, String>();
			env.put(Context.INITIAL_CONTEXT_FACTORY, context_fac);
			env.put(Context.PROVIDER_URL, url);
			// env.put(Context.SECURITY_CREDENTIALS,"weblogic");
			// env.put(Context.SECURITY_PRINCIPAL,"weblogic");

			Context ctx = new InitialContext(env);
			return ctx;
		} catch (NamingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void test() throws Exception {
		Context ctx = useContext();
		TopicConnectionFactory factory = (TopicConnectionFactory) ctx.lookup("javax.jms.TopicConnectionFactory");
		TopicConnection con = factory.createTopicConnection();
		TopicSession session = con.createTopicSession(false, Session.AUTO_ACKNOWLEDGE);
		System.out.println("create session");
		TextMessage message = session.createTextMessage("hello jms");
		System.out.println("create message");
		
		Topic topic = (Topic) ctx.lookup("jms/myTopic");
		TopicPublisher publisher = session.createPublisher(topic);
		System.out.println("create publisher");
		publisher.publish(message);
		System.out.println("publish message");
	}
	
	public static void main(String[] args) throws Exception {
		TestJMS.test();
	}

}
