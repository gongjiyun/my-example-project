package com.learning.example.activemq;

import javax.jms.Message;
import javax.jms.MessageConsumer;
import javax.jms.MessageListener;
import javax.jms.MessageProducer;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.jms.TextMessage;

import com.learning.example.AMQConstants;
import org.apache.activemq.ActiveMQConnectionFactory;

public class ActiveMQResponse implements MessageListener{
	
	private Session session;
	public ActiveMQResponse(Session session){
		this.session = session;
	}

	public static void main(String[] args) throws Exception {
		ActiveMQConnectionFactory cf = new ActiveMQConnectionFactory("failover://(tcp://localhost:61616?wireFormat.cacheEnabled=true)");
		cf.setCopyMessageOnSend(false);
		
		QueueConnection connection = cf.createQueueConnection(AMQConstants.CONNECTION_USER, AMQConstants.CONNECTION_PASSWORD);
		connection.start();
		QueueSession session = connection.createQueueSession(false, Session.AUTO_ACKNOWLEDGE);
		Queue queue = session.createQueue("service.queue");
		
		MessageConsumer consumer = session.createConsumer(queue);
		consumer.setMessageListener(new ActiveMQResponse(session));
	}

	@Override
	public void onMessage(Message arg0) {
		try {
			System.out.println(arg0);
			
			
			TextMessage message = session.createTextMessage();
			message.setJMSReplyTo(arg0.getJMSReplyTo());
			message.setJMSCorrelationID(arg0.getJMSCorrelationID());
			message.setText("response as " + arg0);
			
			MessageProducer producter = session.createProducer(arg0.getJMSReplyTo());
			producter.send(message);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
