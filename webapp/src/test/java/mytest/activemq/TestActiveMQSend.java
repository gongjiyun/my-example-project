package mytest.activemq;

import java.net.URISyntaxException;

import javax.jms.Destination;
import javax.jms.MessageProducer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

public class TestActiveMQSend {

	/**
	 * @param args
	 * @throws Exception
	 * @throws URISyntaxException
	 */
	public static void main(String[] args) throws Exception {

		ActiveMQConnectionFactory af = new ActiveMQConnectionFactory("tcp://localhost:61616");
		af.setPassword("activemq");
		af.setUserName("activemq");
		af.setAlwaysSyncSend(true);
		af.setAlwaysSessionAsync(true);
		//af.setCloseTimeout(1);
		ActiveMQConnection con = (ActiveMQConnection) af.createConnection();
		con.start();
		Session session = con.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination destination = session.createQueue("jms/tcpQueue");
		MessageProducer producer = session.createProducer(destination);
		TextMessage message = session.createTextMessage("hello jms");
		message.setStringProperty("headname", "remoteB");
		producer.send(message);
		session.close();
		con.stop();
		con.close();
		System.out.println("send success.");
	}

}
