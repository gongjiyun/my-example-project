package mytest.activemq;

import java.net.URISyntaxException;

import javax.jms.Connection;
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
		af.setPassword("password");
		af.setUserName("admin");
		af.setAlwaysSyncSend(true);
		af.setAlwaysSessionAsync(true);
		af.setCloseTimeout(1000);
		Connection con = (ActiveMQConnection) af.createConnection();
		con.start();
		Session session = con.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination destination = session.createQueue("queue://example");
		MessageProducer producer = session.createProducer(destination);
		TextMessage message = session.createTextMessage("hello jms");
		message.setStringProperty("headname", "remoteB");
		producer.send(message);
		session.close();
		con.stop();
		con.close();
	}

}
