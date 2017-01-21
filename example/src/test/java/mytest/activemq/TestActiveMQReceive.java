package mytest.activemq;

import javax.jms.Connection;
import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

public class TestActiveMQReceive {

	public static void main(String[] args) throws Exception {
		
		ActiveMQConnectionFactory af = new ActiveMQConnectionFactory(
				"tcp://localhost:61616");
		af.setPassword("password");
		af.setUserName("admin");
		Connection con = (Connection) af.createConnection();
		con.start();
		
		Session session = con.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination destination = session.createQueue("queue://example");
		MessageConsumer consumer = session.createConsumer(destination);
		Message message = consumer.receive(1000);
		if (message instanceof TextMessage) {
			System.out
					.println("message : " + ((TextMessage) message).getText());
		}
		con.stop();
		con.close();

	}
}
