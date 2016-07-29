package mytest.activemq;

import javax.jms.Destination;
import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnection;
import org.apache.activemq.ActiveMQConnectionFactory;

public class TestActiveMQReceive {

	public static void main(String[] args) throws Exception {
		
		ActiveMQConnectionFactory af = new ActiveMQConnectionFactory(
				"tcp://localhost:61616");
		af.setPassword("123");
		af.setUserName("jiyun");
		ActiveMQConnection con = (ActiveMQConnection) af.createConnection();
		con.start();
		Session session = con.createSession(false, Session.AUTO_ACKNOWLEDGE);
		Destination destination = session.createQueue("jms/tcpQueue");
		MessageConsumer consumer = session.createConsumer(destination);
		Message message = consumer.receive(1000);
		if (message instanceof TextMessage) {
			System.out
					.println("message : " + ((TextMessage) message).getText());
		}
		System.out.println("receive succcess");
		con.stop();
		con.close();

	}
}
