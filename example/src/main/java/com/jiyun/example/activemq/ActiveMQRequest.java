package com.jiyun.example.activemq;

import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueRequestor;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;

import org.apache.activemq.ActiveMQConnectionFactory;

import com.jiyun.example.AMQConstants;

public class ActiveMQRequest {

	public static void main(String[] args) throws Exception {
		ActiveMQConnectionFactory cf = new ActiveMQConnectionFactory("failover://(tcp://localhost:61616?wireFormat.cacheEnabled=true)");
		QueueConnection connection = cf.createQueueConnection(AMQConstants.CONNECTION_USER, AMQConstants.CONNECTION_PASSWORD);
		connection.start();
		QueueSession session = connection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
		Queue queue = session.createQueue("service.queue");
		QueueRequestor requestor = new QueueRequestor(session, queue);
		for (int i = 0; i < 10; i++) {
			TextMessage msg = session.createTextMessage("test msg: " + i);
			TextMessage result = (TextMessage) requestor.request(msg);
			System.err.println("Result = " + result.getText());
		}
		connection.close();
	}

}
